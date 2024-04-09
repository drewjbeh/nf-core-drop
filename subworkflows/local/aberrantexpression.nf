// TODO nf-core: If in doubt look at other nf-core/subworkflows to see how we are doing things! :)
//               https://github.com/nf-core/modules/tree/master/subworkflows
//               You can also ask for help via your pull request or on the #subworkflows channel on the nf-core Slack workspace:
//               https://nf-co.re/join
// TODO nf-core: A subworkflow SHOULD import at least two modules

include { ABEXP_PREPROCESS       } from '../../../modules/local/aberrantexpression/preprocessgeneannotation'
include { ABEXP_COUNTREADS       } from '../../../modules/local/aberrantexpression/countreads'
include { ABEXP_MERGECOUNTS      } from '../../../modules/local/aberrantexpression/mergecounts'
include { ABEXP_FILTERCOUNTS     } from '../../../modules/local/aberrantexpression/filtercounts'
include { ABEXP_OUTRIDER_RUN     } from '../../../modules/local/aberrantexpression/outriderrun'
include { ABEXP_OUTRIDER_RESULTS } from '../../../modules/local/aberrantexpression/outriderresults'

workflow ABERRANTEXPRESSION {

    take:
    // TODO nf-core: edit input (take) channels
    ch_bam // channel: [ val(meta), [ bam ] ]

    main:

    ch_versions = Channel.empty()

    // TODO nf-core: substitute modules here for the modules of your subworkflow

    ABEXP_PREPROCESS ( ch_bam )
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

