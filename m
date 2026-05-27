Return-Path: <cgroups+bounces-16357-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDAzIqMRF2o12wcAu9opvQ
	(envelope-from <cgroups+bounces-16357-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:45:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 297605E718D
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DB733052A7B
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A8342B74A;
	Wed, 27 May 2026 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sYHo+u+R"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2073AA507
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896692; cv=none; b=XRahqH9EWFY2zv33+dZtP5KU3pxPFsp9dg6C2El4n7LOCoFWtkzXf/kv8YxcJEjlqnXEVWgYyLUxF/KF/UzROYN/WPj/0SbDW97aWXyfQ2eFcXUE4VA4pQTp5sIsCtZkb3tpROar2P1GzNTDZiGkSJUXO2DGmYOg5NW8b9FxoJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896692; c=relaxed/simple;
	bh=JRVgpFmbRjh7bJLYYJjYzs1K0iJKy2BpBuHo3cYsDfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAP6xDccGX07igeqNMscpqyxLg7R+7ESl+pl9gYddqPE0LtxFBW42KNnjk1MiFkVXF6jg0fYsOnGcDu/41R9KWxD9uOOnu2C9UY98mGi9wkBrXXp1OFeo5+xxJaXnOVr+NVVmkN00QRQtyJwJg268B8xHv0/SxZRuM+lM8lam+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sYHo+u+R; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2fd62ec0-c594-4ac2-a95d-29eafbcb74d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779896678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fswUnI9q78WgkM0igmVl4iKvvWN/p7M51WA068cywCs=;
	b=sYHo+u+R/Ay7Axr7WPIVp6rQyo9OifxAVtBZ97wRRuu2Y/F3gQXObPgpFrLOasaSj2yf1d
	RSBieMqGfnG8lVEpcH0Fu9GasO6+hNDg0g2UUOBvj5tOv5wKk2h2hah7ESxfO2PbmcHWuC
	2K41sPVIUTq+HSP7teOoOuMIe8BS3RA=
Date: Wed, 27 May 2026 08:43:54 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v7 04/11] libbpf: introduce
 bpf_map__attach_struct_ops_opts()
Content-Language: en-GB
To: Hui Zhu <hui.zhu@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 JP Kobryn <inwardvessel@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, KP Singh <kpsingh@kernel.org>,
 Tao Chen <chen.dylane@linux.dev>, Mykyta Yatsenko <yatsenko@meta.com>,
 Leon Hwang <leon.hwang@linux.dev>,
 Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung
 <ameryhung@gmail.com>, Tobias Klauser <tklauser@distanz.ch>,
 Eyal Birger <eyal.birger@gmail.com>, Rong Tao <rongtao@cestc.cn>,
 Hao Luo <haoluo@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Kees Cook <kees@kernel.org>, Tejun Heo <tj@kernel.org>,
 Jeff Xu <jeffxu@chromium.org>, mkoutny@suse.com,
 Jan Hendrik Farr <kernel@jfarr.cc>, Christian Brauner <brauner@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Willem de Bruijn
 <willemb@google.com>, Jason Xing <kerneljasonxing@gmail.com>,
 Paul Chaignon <paul.chaignon@gmail.com>,
 Chen Ridong <chenridong@huaweicloud.com>, Lance Yang <lance.yang@linux.dev>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: geliang@kernel.org, baohua@kernel.org
References: <cover.1779760876.git.zhuhui@kylinos.cn>
 <20bdaa33cc19364f5f10208c79ef94fe43bd5ac1.1779760876.git.zhuhui@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20bdaa33cc19364f5f10208c79ef94fe43bd5ac1.1779760876.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16357-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,cmpxchg.org,linux-foundation.org,davemloft.net,fomichev.me,meta.com,distanz.ch,cestc.cn,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,huaweicloud.com,vger.kernel.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[58];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yonghong.song@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 297605E718D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/26 7:20 PM, Hui Zhu wrote:
> From: Roman Gushchin <roman.gushchin@linux.dev>
>
> Introduce bpf_map__attach_struct_ops_opts(), an extended version of
> bpf_map__attach_struct_ops(), which takes additional struct
> bpf_struct_ops_opts argument.
>
> This allows to pass a target_fd argument and the BPF_F_CGROUP_FD flag
> and attach the struct ops to a cgroup as a result.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>   tools/lib/bpf/libbpf.c   | 20 +++++++++++++++++---
>   tools/lib/bpf/libbpf.h   | 14 ++++++++++++++
>   tools/lib/bpf/libbpf.map |  1 +
>   3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1e8688975d16..a1b54da1ded2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13683,11 +13683,18 @@ static int bpf_link__detach_struct_ops(struct bpf_link *link)
>   	return close(link->fd);
>   }
>   
> -struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
> +struct bpf_link *bpf_map__attach_struct_ops_opts(const struct bpf_map *map,
> +						 const struct bpf_struct_ops_opts *opts)
>   {
> +	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts);
>   	struct bpf_link_struct_ops *link;
> +	int err, fd, target_fd;
>   	__u32 zero = 0;
> -	int err, fd;
> +
> +	if (!OPTS_VALID(opts, bpf_struct_ops_opts)) {
> +		pr_warn("map '%s': invalid opts\n", map->name);
> +		return libbpf_err_ptr(-EINVAL);
> +	}
>   
>   	if (!bpf_map__is_struct_ops(map)) {
>   		pr_warn("map '%s': can't attach non-struct_ops map\n", map->name);
> @@ -13724,7 +13731,9 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>   		return &link->link;
>   	}
>   
> -	fd = bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
> +	link_opts.flags = OPTS_GET(opts, flags, 0);
> +	target_fd = OPTS_GET(opts, target_fd, 0);
> +	fd = bpf_link_create(map->fd, target_fd, BPF_STRUCT_OPS, &link_opts);
>   	if (fd < 0) {
>   		free(link);
>   		return libbpf_err_ptr(fd);
> @@ -13736,6 +13745,11 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>   	return &link->link;
>   }
>   
> +struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
> +{
> +	return bpf_map__attach_struct_ops_opts(map, NULL);
> +}
> +
>   /*
>    * Swap the back struct_ops of a link with a new struct_ops map.
>    */
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index bba4e8464396..18af178547ad 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -945,6 +945,20 @@ bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgroup_fd,
>   struct bpf_map;
>   
>   LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
> +
> +struct bpf_struct_ops_opts {
> +	/* size of this struct, for forward/backward compatibility */
> +	size_t sz;
> +	__u32 flags;
> +	__u32 target_fd;
> +	__u64 expected_revision;
> +	size_t :0;
> +};
> +#define bpf_struct_ops_opts__last_field expected_revision
> +
> +LIBBPF_API struct bpf_link *
> +bpf_map__attach_struct_ops_opts(const struct bpf_map *map,
> +				const struct bpf_struct_ops_opts *opts);
>   LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map);
>   
>   struct bpf_iter_attach_opts {
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index dfed8d60af05..6105619b5ecf 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -454,6 +454,7 @@ LIBBPF_1.7.0 {
>   		bpf_prog_assoc_struct_ops;
>   		bpf_program__assoc_struct_ops;
>   		btf__permute;
> +		bpf_map__attach_struct_ops_opts;

Function bpf_map__attach_struct_ops_opts should be in
LIBBPF_1.8.0.

>   } LIBBPF_1.6.0;
>   
>   LIBBPF_1.8.0 {


