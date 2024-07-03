Return-Path: <cgroups+bounces-3516-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6EB9256FF
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10BB1C24A59
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2313C9B9;
	Wed,  3 Jul 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bBlUgVy5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bBlUgVy5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793942A80;
	Wed,  3 Jul 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999630; cv=none; b=npKttwlu906t5MsbpW075eAhWpbhml4jPyMTQuP8Ac+deNVLf5udzprwwspF9s4t81L31Mlr+xTPbfEayzMgC0jkUnz4ojYN9BALtcvZwDqzPQtPX/e2lKtpVYd2AqApCyRWzCc+RhNMK+EnIrsXaXB1mTmGWjDBQiBE8wJECkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999630; c=relaxed/simple;
	bh=VF4zOfp2HVAfvxXAazB7UXoEc+pWRj0KtSXAGFYYAhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaMlHzuKGT+Vk4sqJMdpoA33M1rj3fKOpytjYOLs5MKxQgWuXn/66+5pkndQtRtvxaluKxhdRLyaHf1Bs1Q6KcVchSwooeAfzY113hbeLXkMWbvowpWsu87KCHUFTZZEl7qkhMYFX2n3rIeS2jwQeqLBUueQ1bCo0xmqhi4i/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bBlUgVy5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bBlUgVy5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 919C31FCD5;
	Wed,  3 Jul 2024 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719999626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWpliwuofIUaoa9DH3w85OQJcNQA42BSQhh8IA8D9po=;
	b=bBlUgVy5WfdnVmXm73Y4uq/BGBYfNP4Je0Z4y1Ywp3UoDzGN0Z6uu2aF8p6h8Feqb+5NPV
	3p6lxnmCiqzz41IM79pHpfFOlJRdbFWyM3jc2G9CcxIlqsMBnnNe7v2nzrImFORRT72HT3
	iN3shzbEWqGfG6gEL1IplAeax3LJ2CQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bBlUgVy5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719999626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWpliwuofIUaoa9DH3w85OQJcNQA42BSQhh8IA8D9po=;
	b=bBlUgVy5WfdnVmXm73Y4uq/BGBYfNP4Je0Z4y1Ywp3UoDzGN0Z6uu2aF8p6h8Feqb+5NPV
	3p6lxnmCiqzz41IM79pHpfFOlJRdbFWyM3jc2G9CcxIlqsMBnnNe7v2nzrImFORRT72HT3
	iN3shzbEWqGfG6gEL1IplAeax3LJ2CQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80ADF13974;
	Wed,  3 Jul 2024 09:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4jApH4ochWbIWQAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Wed, 03 Jul 2024 09:40:26 +0000
Date: Wed, 3 Jul 2024 11:40:25 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Xavier <xavier_qy@163.com>
Cc: tj@kernel.org, longman@redhat.com, akpm@linux-foundation.org, 
	lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH-cpuset v10 1/2] Union-Find: add a new module in kernel
 library
Message-ID: <haimyc4y2trcyvbnkpw2gkfoiaunykb2q2d5ybr6qgt6upf3lm@afhcevtyjcjl>
References: <ZoRThI4lcZLxBlwc@slm.duckdns.org>
 <20240703063727.258722-1-xavier_qy@163.com>
 <20240703063727.258722-2-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vy2dacd5pm46dbnj"
Content-Disposition: inline
In-Reply-To: <20240703063727.258722-2-xavier_qy@163.com>
X-Spamd-Result: default: False [-6.11 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 919C31FCD5
X-Spam-Flag: NO
X-Spam-Score: -6.11
X-Spam-Level: 


--vy2dacd5pm46dbnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 02:37:26PM GMT, Xavier <xavier_qy@163.com> wrote:
> This patch implements a union-find data structure in the kernel library,
> which includes operations for allocating nodes, freeing nodes,
> finding the root of a node, and merging two nodes.
>=20
> Signed-off-by: Xavier <xavier_qy@163.com>
> ---
>  Documentation/core-api/union_find.rst         | 102 ++++++++++++++++++
>  .../zh_CN/core-api/union_find.rst             |  87 +++++++++++++++
>  MAINTAINERS                                   |   9 ++
>  include/linux/union_find.h                    |  41 +++++++
>  lib/Makefile                                  |   2 +-
>  lib/union_find.c                              |  48 +++++++++
>  6 files changed, 288 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/core-api/union_find.rst
>  create mode 100644 Documentation/translations/zh_CN/core-api/union_find.=
rst
>  create mode 100644 include/linux/union_find.h
>  create mode 100644 lib/union_find.c
>=20

Nice.
I'd so s/Union-Find/union-find/ both in the docs and the code
(comments), I didn't find any rule why two capitalizations are used.

> +struct uf_node {
> +	struct uf_node *parent;
> +	unsigned int rank;
> +};
> +
> +/* This macro is used for static initialization of a union-find node. */
> +#define UF_INIT_NODE(node)	{.parent =3D &node, .rank =3D 0}
> +
> +/**
> + * uf_node_init - Initialize a union-find node
> + * @node: pointer to the union-find node to be initialized
> + *
> + * This function sets the parent of the node to itself and
> + * initializes its rank to 0.
> + */
> +static inline void uf_node_init(struct uf_node *node)
> +{
> +	node->parent =3D node;
> +	node->rank =3D 0;
> +}

Xavier, not sure if you responded to my suggestion of considered zeroed
object a valid initialized one. That could save some init work (and
move it to alternative uf_find, see below).

> + * This function returns the root of the node by following the parent
> + * pointers. It also performs path compression, making the tree shallowe=
r.
> + *
> + * Returns the root node of the set containing node.
> + */
> +struct uf_node *uf_find(struct uf_node *node)
> +{
> +	struct uf_node *parent;
> +

With uf_find body checking for NULL:

	while (node->parent !=3D node) {
		parent =3D node->parent;
		node->parent =3D parent ? parent->parent : node;
		node =3D node->parent;
	}

> +/**
> + * uf_union - Merge two sets, using union by rank
> + * @node1: the first node
> + * @node2: the second node
> + *
> + * This function merges the sets containing node1 and node2, by comparing
> + * the ranks to keep the tree balanced.
> + */
> +void uf_union(struct uf_node *node1, struct uf_node *node2)
> +{
> +	struct uf_node *root1 =3D uf_find(node1);
> +	struct uf_node *root2 =3D uf_find(node2);
> +
> +	if (root1 !=3D root2) {

if (root1 =3D=3D root2)
	return;
then the rest can be one level less nested ;-)

Michal

--vy2dacd5pm46dbnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZoUchgAKCRAt3Wney77B
SRH+AP4228g6+JheJFzOPr5Phwffp3mdByo4uQni13UjLb4/owEA5J4dnXTEnZhH
1jeK7wxG34710AbStWSS52m9nN0qXAw=
=wcRx
-----END PGP SIGNATURE-----

--vy2dacd5pm46dbnj--

