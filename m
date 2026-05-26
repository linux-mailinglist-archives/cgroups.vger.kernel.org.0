Return-Path: <cgroups+bounces-16282-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDSgIFIRFWr/SQcAu9opvQ
	(envelope-from <cgroups+bounces-16282-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:19:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E125D04DB
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B11CD3023E39
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 03:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B566F3B2FCD;
	Tue, 26 May 2026 03:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fzd15vWW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03663B27E9;
	Tue, 26 May 2026 03:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765574; cv=none; b=U9uf2EDvMISMJIvzi1t27m22AySPOqFttzMNr+ahyd/EibjhEhc4tem3k6lAbzfhQO5zp/wouv3/KObsboesyEOCGbg68Wix2Wjta6FTBZhPVddFDgCPDL9t4YxeeyUsBE6lDeedLXJWlVW1BYBiy+2OqehGPy70Xmjf1Ryk+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765574; c=relaxed/simple;
	bh=6CORgfPFQ9puMQwblCILR92soSMWiBjd4t+R7/iVJr0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EEbymESJHtAImz+23Y/ohfnJ7k8Pc62v/+VB7ZbdviSAPpp5l3uA+ta4OxEpWci9okxld2sV3K6sEVZ12K70BDUhByZq1m1ZGXt4a65f71ieH6UWkFXXK+pwEUnxpYuLXf8a9Ow4b0zV/DXG/VypNAIWr1evDESe/75i4T06xgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fzd15vWW reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7761F00A3A;
	Tue, 26 May 2026 03:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779765572;
	bh=fqDemX/FdOBkBnC5ZP9UcI550Lp4WB10rVWgF62/WPE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Fzd15vWWyuYXLNpPYgTplgKtYq8F2XR5KRsMEcF8xi2CD72aP31LWYlDErz9DBd+J
	 opHg/6+RBvpOe+ogUW/8tC48Sr4O6K1U0yzALBoShK+RaMDlUG5FsZdh2Av0bPEdxU
	 /RvangL28JkJBl5vUxjGFNwHlEespD8WpeXZ1mNgt6sNJ6D268ysX7OGYuUZVM0ucQ
	 r2b5NQAaSa/B+1193b424wq9mVvcyo4qxECiHgNDbnhOVE0jwdFipHIEkGMwEw1jkQ
	 lZZBXlWsy21t5+XLv6AmZDg2+4jwjQNvGFHVz9NnOOHgXJzgrSc2lhdUMy7nDAjqtj
	 zIjNyT3zxQ8hg==
Content-Type: multipart/mixed; boundary="===============2941777259395279126=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cf69281a5bdcb9c508d5b856610ec86893ad95e1d8dd4586b72b65fcb595ed61@mail.kernel.org>
In-Reply-To: <a7bf069cbc39930fad3740269aa82f1acadb029b.1779760876.git.zhuhui@kylinos.cn>
References: <a7bf069cbc39930fad3740269aa82f1acadb029b.1779760876.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v7 02/11] bpf: allow attaching struct_ops to cgroups
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, inwardvessel@gmail.com,
	akpm@linux-foundation.org, shuah@kernel.org, davem@davemloft.net,
	kuba@kernel.org, hawk@kernel.org, sdf@fomichev.me,
	kpsingh@kernel.org, chen.dylane@linux.dev, yatsenko@meta.com,
	leon.hwang@linux.dev, a.s.protopopov@gmail.com, ameryhung@gmail.com,
	tklauser@distanz.ch, eyal.birger@gmail.com, rongtao@cestc.cn,
	haoluo@google.com, peterz@infradead.org, ojeda@kernel.org,
	nathan@kernel.org, kees@kernel.org, tj@kernel.org,
	jeffxu@chromium.org, mkoutny@suse.com, kernel@jfarr.cc,
	brauner@kernel.org, rdunlap@infradead.org, brgerst@gmail.com,
	masahiroy@kernel.org, willemb@google.com, kerneljasonxing@gmail.com,
	paul.chaignon@gmail.com, chenridong@huaweicloud.com,
	lance.yang@linux.dev, jiayu@web.codeaurora.org, an.chen@linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: geliang@kernel.org,baohua@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 03:19:31 +0000 (UTC)
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	TAGGED_FROM(0.00)[bounces-16282-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,cmpxchg.org,linux-foundation.org,davemloft.net,fomichev.me,meta.com,distanz.ch,cestc.cn,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,huaweicloud.com,web.codeaurora.org,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[68];
	NEURAL_HAM(-0.00)[-0.737];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: E7E125D04DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============2941777259395279126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index dd4f34e041ab..bd1b94a618ad 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1922,6 +1922,9 @@ struct bpf_raw_tp_link {
>  struct bpf_struct_ops_link {
>  	struct bpf_link link;
>  	struct bpf_map __rcu *map;
> +	struct cgroup *cgroup;
> +	bool cgroup_removed;
> +	struct list_head list;
>  	wait_queue_head_t wait_hup;
>  };

Yafang Shao raised a design concern about the struct_ops_link structure:
The struct has hardcoded cgroup-specific fields. He suggested a more
generic solution using 'int type' and 'void *private' fields to support
other structs (task, etc.) in the future. This design feedback was not
addressed or responded to.

Reference: https://lore.kernel.org/bpf/CALOAHbDXmgi=yeB1c2zzQ7-Lz2+MEZvtbxQp1=mWXMJSsg3sgQ@mail.gmail.com/

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index aec171ccb6ef..f547613986cc 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1246,6 +1246,7 @@ enum bpf_perf_event_type {
>  #define BPF_F_AFTER		(1U << 4)
>  #define BPF_F_ID		(1U << 5)
>  #define BPF_F_PREORDER		(1U << 6)
> +#define BPF_F_CGROUP_FD		(1U << 7)
>  #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */

Since both fdinfo and link_info show the cgroup ID, would BPF_F_CGROUP_ID
be a better name than BPF_F_CGROUP_FD for alignment?

This naming suggestion came from Yafang Shao and was not addressed or
responded to.

Reference: https://lore.kernel.org/bpf/CALOAHbDXmgi=yeB1c2zzQ7-Lz2+MEZvtbxQp1=mWXMJSsg3sgQ@mail.gmail.com/

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 7ad3b1a49dee..e63f926d8728 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -1264,6 +1270,7 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
>  {
>  	struct bpf_struct_ops_link *st_link;
>  	struct bpf_map *map;
> +	u64 cgrp_id = 0;

Assigning 0 to cgrp_id would technically be incorrect. The cgroup_id()
function returns 1 for !CONFIG_CGROUPS, and for CONFIG_CGROUPS the ID
allocation via idr_alloc_cyclic() uses a range between 1 and INT_MAX.
Would a sentinel value like (u64)-1 be more appropriate?

Matt Bobrowski raised this concern and Roman acknowledged the review,
but this was not fixed in the current version.

Reference: https://lore.kernel.org/bpf/aXnyKw5sRt_MB-8A@google.com/

> @@ -1271,6 +1278,14 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
>  	if (map)
>  		seq_printf(seq, "map_id:\t%d\n", map->id);
>  	rcu_read_unlock();
> +
> +	cgroup_lock();
> +	if (st_link->cgroup)
> +		cgrp_id = cgroup_id(st_link->cgroup);
> +	cgroup_unlock();

Could an inline helper be introduced for the cgroup_lock()/cgroup_id()/
cgroup_unlock() pattern? This same dance appears in both
bpf_struct_ops_map_link_show_fdinfo() and
bpf_struct_ops_map_link_fill_link_info().

Matt Bobrowski suggested this and Roman said he would try, but the
helper was not added in the current version.

Reference: https://lore.kernel.org/bpf/aXnyKw5sRt_MB-8A@google.com/

> @@ -1393,8 +1422,12 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>  	struct bpf_link_primer link_primer;
>  	struct bpf_struct_ops_map *st_map;
>  	struct bpf_map *map;
> +	struct cgroup *cgrp;
>  	int err;
>
> +	if (attr->link_create.flags & ~BPF_F_CGROUP_FD)
> +		return -EINVAL;

Should all the cgroup-related logic be protected by CONFIG_CGROUPS ifdef?
Both cgroup_get_from_fd() and cgroup_put() lack stubs when building with
!CONFIG_CGROUPS. Should BPF_F_CGROUP_FD only be accepted when
CONFIG_BPF_CGROUP is enabled, returning -EOPNOTSUPP otherwise?

Matt Bobrowski raised this and Roman acknowledged the review, but these
guards were not added in the current version.

Reference: https://lore.kernel.org/bpf/aXnyKw5sRt_MB-8A@google.com/

> @@ -1414,11 +1447,26 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>  	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL,
>  		      attr->link_create.attach_type);
>
> +	init_waitqueue_head(&link->wait_hup);
> +
> +	if (attr->link_create.flags & BPF_F_CGROUP_FD) {
> +		cgrp = cgroup_get_from_fd(attr->link_create.target_fd);
> +		if (IS_ERR(cgrp)) {
> +			err = PTR_ERR(cgrp);
> +			goto err_out;
> +		}
> +		link->cgroup = cgrp;
> +		err = cgroup_bpf_attach_struct_ops(cgrp, link);
> +		if (err) {
> +			cgroup_put(cgrp);
> +			link->cgroup = NULL;
> +			goto err_out;
> +		}
> +	}
> +
>  	err = bpf_link_prime(&link->link, &link_primer);
>  	if (err)
> -		goto err_out;
> -
> -	init_waitqueue_head(&link->wait_hup);
> +		goto err_put_cgroup;
>
>  	/* Hold the update_mutex such that the subsystem cannot
>  	 * do link->ops->detach() before the link is fully initialized.
> @@ -1429,13 +1477,16 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>  		mutex_unlock(&update_mutex);
>  		bpf_link_cleanup(&link_primer);
>  		link = NULL;
> -		goto err_out;
> +		goto err_put_cgroup;
>  	}
>  	RCU_INIT_POINTER(link->map, map);
>  	mutex_unlock(&update_mutex);
>
>  	return bpf_link_settle(&link_primer);
>
> +err_put_cgroup:
> +	if (link && link->cgroup)
> +		cgroup_bpf_detach_struct_ops(link->cgroup, link);
>  err_out:
>  	bpf_map_put(map);
>  	kfree(link);

Can the error path here trigger a use-after-free?

After cgroup_bpf_attach_struct_ops() succeeds, the link is added to
cgrp->bpf.struct_ops_links and becomes reachable by cgroup_bpf_release().
If bpf_link_prime() then fails (FD exhaustion or memory pressure), the
error path checks link->cgroup and calls cgroup_bpf_detach_struct_ops().

However, if the cgroup is concurrently destroyed, cgroup_bpf_release()
can run:

  cgroup_bpf_release():
    cgroup_lock()
    list_splice_init(&cgrp->bpf.struct_ops_links, &st_links)
    for each st_link in st_links:
      st_link->cgroup = NULL
      st_link->cgroup_removed = true
      bpf_link_inc_not_zero(&st_link->link)  // refcount 1->2
    cgroup_unlock()
    ...
    st_link->link.ops->detach(&st_link->link)
    bpf_link_put(&st_link->link)

At this point link->cgroup is NULL, so the err_put_cgroup check becomes
a no-op. Control proceeds to err_out and calls kfree(link), freeing the
memory.

Meanwhile, cgroup_bpf_release resumes its second loop and accesses the
already-freed link memory via st_link->link.ops->detach() and
bpf_link_put().

The error path uses kfree(link) directly, bypassing the bpf_link
refcount mechanism. Once the link is added to cgrp->bpf.struct_ops_links,
it becomes exposed to concurrent cgroup_bpf_release which can bump the
refcount. Direct kfree() ignores the additional reference and frees the
memory while the release work still holds a raw pointer.

In contrast, when the post-bpf_link_prime reg() failure occurs, the code
uses bpf_link_cleanup() and sets link = NULL, which is safe because it
relies on the refcount mechanism.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 876f6a81a9b6..b593ebb30a4e 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -307,12 +308,23 @@ static void cgroup_bpf_release(struct work_struct *work)
>  					       bpf.release_work);
>  	struct bpf_prog_array *old_array;
>  	struct list_head *storages = &cgrp->bpf.storages;
> +	struct bpf_struct_ops_link *st_link, *st_tmp;
>  	struct bpf_cgroup_storage *storage, *stmp;
> +	LIST_HEAD(st_links);
>
>  	unsigned int atype;
>
>  	cgroup_lock();
>
> +	list_splice_init(&cgrp->bpf.struct_ops_links, &st_links);
> +	list_for_each_entry_safe(st_link, st_tmp, &st_links, list) {
> +		st_link->cgroup = NULL;
> +		st_link->cgroup_removed = true;
> +		cgroup_put(cgrp);
> +		if (IS_ERR(bpf_link_inc_not_zero(&st_link->link)))
> +			list_del(&st_link->list);
> +	}

Does this loop have the correct ordering for concurrent link dealloc?

The first loop writes to st_link memory (st_link->cgroup = NULL,
st_link->cgroup_removed = true) before calling bpf_link_inc_not_zero()
to take a reference.

Meanwhile, if userspace closes the link FD and the refcount drops to 0,
bpf_struct_ops_map_link_dealloc() runs:

  bpf_struct_ops_map_link_dealloc():
    st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
    if (st_link->cgroup)
      cgroup_bpf_detach_struct_ops(st_link->cgroup, st_link);
    kfree(st_link);

The dealloc path reads st_link->cgroup without holding cgroup_mutex.
If this read sees the NULL written by cgroup_bpf_release, dealloc skips
cgroup_bpf_detach_struct_ops() and proceeds to kfree(st_link).

At that point, cgroup_bpf_release continues and performs use-after-free
on the freed st_link memory:

  st_link->cgroup_removed = true         // UAF write
  bpf_link_inc_not_zero(&st_link->link)  // UAF atomic on freed memory
  list_del(&st_link->list)               // UAF / list corruption

The link is on cgrp->bpf.struct_ops_links but list membership does not
increment the link refcount. The cgroup_lock would only synchronize the
dealloc path if dealloc unconditionally took it, but dealloc takes
cgroup_lock conditionally on (st_link->cgroup), which the racing writer
just nulled.

Would it be safer to call bpf_link_inc_not_zero() first before touching
st_link's other fields?

> @@ -2755,3 +2773,31 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> +void cgroup_bpf_detach_struct_ops(struct cgroup *cgrp,
> +				  struct bpf_struct_ops_link *link)
> +{
> +	cgroup_lock();
> +	if (link->cgroup == cgrp) {
> +		list_del(&link->list);
> +		link->cgroup = NULL;
> +		cgroup_put(cgrp);
> +	}
> +	cgroup_unlock();
> +}

Is the cgrp parameter needed in cgroup_bpf_attach_struct_ops() and
cgroup_bpf_detach_struct_ops()? Both Matt Bobrowski and Josh Don
suggested that both functions should operate on link->cgroup instead,
with a !link->cgroup being considered -EINVAL. Roman acknowledged with
'Ack' and 'Sure, good point' but the parameter was not removed.

Reference: https://lore.kernel.org/bpf/aXnyKw5sRt_MB-8A@google.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26429228214
--===============2941777259395279126==--

