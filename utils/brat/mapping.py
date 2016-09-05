from protolib.python import document_pb2

entity_type_to_str = {
    document_pb2.Entity.MIRNA: 'MiRNA',
    document_pb2.Entity.GENE: 'Gene',
    document_pb2.Entity.TRIGGER: 'Trigger',
    document_pb2.Entity.SUBCELLULAR_LOCATION: 'Subcellular_location',
    document_pb2.Entity.UNSET: 'Entity',
    # document_pb2.Entity.DISEASE: 'Sentence'
}

str_to_entity_type = {
    'mirna': document_pb2.Entity.MIRNA,
    'gene': document_pb2.Entity.GENE,
    'protein': document_pb2.Entity.GENE,
    # BioInfer corpus types.
    'gene/protein/rna': document_pb2.Entity.GENE,
    'individual_protein': document_pb2.Entity.GENE,
    'protein_family_or_group': document_pb2.Entity.GENE,
    'protein_complex': document_pb2.Entity.GENE,
    'dna_family_or_group': document_pb2.Entity.GENE,
    # BioNLP corpus types.
    'trigger': document_pb2.Entity.TRIGGER,
    'localization': document_pb2.Entity.TRIGGER,
    'subcellular_location': document_pb2.Entity.SUBCELLULAR_LOCATION,
    'entity': document_pb2.Entity.UNSET,
    # 'Sentence': document_pb2.Entity.DISEASE
}
