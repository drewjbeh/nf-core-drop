// TODO nf-core: If in doubt look at other nf-core/subworkflows to see how we are doing things! :)
//               https://github.com/nf-core/modules/tree/master/subworkflows
//               You can also ask for help via your pull request or on the #subworkflows channel on the nf-core Slack workspace:
//               https://nf-co.re/join
// TODO nf-core: A subworkflow SHOULD import at least two modules

include { ABSPLICE_DEFINEDATASETSFROMANNO       } from '../../../modules/local/aberrantsplicing/definedatasetsfromanno'
include { ABSPLICE_COUNTRNA_INIT                } from '../../../modules/local/aberrantsplicing/countrnainit'
include { ABSPLICE_COUNTRNA_SPLITREADS          } from '../../../modules/local/aberrantsplicing/countrnasplitreads'
include { ABSPLICE_COUNTRNA_SPLITREADS_MERGE    } from '../../../modules/local/aberrantsplicing/countrnasplitreadsmerge'
include { ABSPLICE_COUNTRNA_NONSPLITREADS       } from '../../../modules/local/aberrantsplicing/countrnanonsplitreads'
include { ABSPLICE_COUNTRNA_NONSPLITREADS_MERGE } from '../../../modules/local/aberrantsplicing/countrnanonsplitreadsmerge'
include { ABSPLICE_COUNTRNA_COLLECT             } from '../../../modules/local/aberrantsplicing/countrnacollect'
include { ABSPLICE_CALCULATEPSI                 } from '../../../modules/local/aberrantsplicing/calculatepsi'
include { ABSPLICE_FILTER                       } from '../../../modules/local/aberrantsplicing/filter'
include { ABSPLICE_FITHYPERPARAMS               } from '../../../modules/local/aberrantsplicing/fithyperparams'
include { ABSPLICE_AUTOENCODER                  } from '../../../modules/local/aberrantsplicing/autoencoder'



workflow ABERRANTSPLICING {

    take:
    // TODO nf-core: edit input (take) channels
    ch_bam // channel: [ val(meta), [ bam ] ]

    main:

    ch_versions = Channel.empty()

    // TODO nf-core: substitute modules here for the modules of your subworkflow

    SAMTOOLS_SORT ( ch_bam )
    ch_versions = ch_versions.mix(SAMTOOLS_SORT.out.versions.first())

    SAMTOOLS_INDEX ( SAMTOOLS_SORT.out.bam )
    ch_versions = ch_versions.mix(SAMTOOLS_INDEX.out.versions.first())

    emit:
    // TODO nf-core: edit emitted channels
    bam      = SAMTOOLS_SORT.out.bam           // channel: [ val(meta), [ bam ] ]
    bai      = SAMTOOLS_INDEX.out.bai          // channel: [ val(meta), [ bai ] ]
    csi      = SAMTOOLS_INDEX.out.csi          // channel: [ val(meta), [ csi ] ]

    versions = ch_versions                     // channel: [ versions.yml ]
}

