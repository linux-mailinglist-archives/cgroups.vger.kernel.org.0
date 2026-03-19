Return-Path: <cgroups+bounces-14924-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD4YJv5NvGkXwwIAu9opvQ
	(envelope-from <cgroups+bounces-14924-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 20:26:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC3B2D1A5A
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 20:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9503330B6144
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 19:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245C938F65C;
	Thu, 19 Mar 2026 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azlytz9z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD6734D903
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948387; cv=pass; b=nrNDjRFdMDI+hA8tO0bMfS+5sUgAzGPh13wpxc+tXNH41AHh3ZCqdNhNccCYi4YZbdCpY7gwc74zdmd9n54DSswJTSfM1m7grzWcMZTt2zS5ysAmK9bNhPHJkPpuC91iDwLNX+PsP/OxHqLezkACJLf/6f6NBkKxuw/KrBakB4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948387; c=relaxed/simple;
	bh=SMnbKcM0hUtzaR1GU2NyR71o3cgHMSUw0IGV8L9jlGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6BxWhkxKys/eLmqMRnNpwRYB4f/5pAHP1wZNSsVq9qC7YXO4d13cG8Kf1bVd9CtMH7pny1n2FUeNX0Eb4/0TxG0xo8qBrGRmAz4JzPxvM5vk0aZPNpuOrT1S7v0sDQemPNbAokPHfiaLUp619z14yKiPmf7q4FAvRvfM8aZawA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azlytz9z; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b4121c40aso877305f8f.0
        for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 12:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773948384; cv=none;
        d=google.com; s=arc-20240605;
        b=lWMPUHQRCdMYk3LrESILLrXGiSRQHtpOFCbP8FhTOPtf9uWeoFWl/N0YpI/Owre3yu
         7kEf+Wisy0LUDfYwc3ts3wOzHAYhicLXmIA2CRqbnZKpKCY2cS5sA57JOqMoGkzPIR7c
         5t02A0sz4xiS0pd8ATK6vTaS7qHoh5LKMEH0xdYJS7z28QCFTUZ664ThW7Fc72/ls7SJ
         qRHzbIzAhSs4dwEJyUX23pUeVlaB7ZXagH8u6kSXGC1aA8ha5nlhP5FGjWygWac24CsX
         0TRe8GFAoe8cnMZIZHNrHFC+Ar0WpfVkK2EwfrbvFAC45oSAPkfGZoA0LGd1vcVNBopH
         5q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=STbYRptw5mPVfwcJPai4/18g1DT8t9j5hz3bTmCzNvY=;
        fh=BgxRO70iKMcPE7BYo0KEaIS0Izr/vLKDlIh6Ju8Pk30=;
        b=MTwt8SQJ1CkiBkjzGRi30zDF4eFU0dLNZQzhXBBYDW8fjfjceXYX67k1ogVkiZZxPq
         onziQGDTJynpNH8RBFTZCJ9JuH5HcDZCvB3QrcviWzF5bKamru/p+mESIPtHkC+7fMG9
         gn6jEyrING+Oyo10anUByuJaKCzwBkoIbcc3DCq3YGH/2UeDggVHSZPVKFPU1C43Po5j
         ZB17JERSfekUOcW6SE4EwFEpfyb5wNOgnw6XH9x648aBKt006e1jbTnaKkTOZ063HUR+
         ebj19m9msrvdoG1E+iY6trs5pgoUqQJj4FVmeDvQLW6pBmYqmpg4fJBNl6K4byZIeB8A
         L+cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773948384; x=1774553184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STbYRptw5mPVfwcJPai4/18g1DT8t9j5hz3bTmCzNvY=;
        b=azlytz9z55giRucLwQBXJnvDsmJgVV+BvIS/FGWSJecbPojKY/ZcQUn8Rj5aDVJgAY
         ZDGLwxyrsNJRRvBEemL15yO608Lxdy+Nn3m/HCX5r5CoXt94c1cmaxTt0chgxeLh+kpZ
         Q6wXw3mIBrdITdVVJR0h0e9y6ZNROAXvyh97dhS4HQzW1CNnx5/GidRn5KSN+zSKa4nK
         39iah9St5FqmEIIOH4831/3EUu+so+c4qqNe5hI57VDjFpuUNicWJA36I9nCcr3hS1u6
         oYSts+zQ17grXi2ECuJQmVIuBz3x51EzlsDTrejuSFq3C1zt4NEl1z5GQ417Vr+A7ohV
         BohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773948384; x=1774553184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=STbYRptw5mPVfwcJPai4/18g1DT8t9j5hz3bTmCzNvY=;
        b=bpIosL5ygjy9Pg41DAKSSgqq3dy/xolwGlqNFnhiM7z6Ql4+yg9mu0Fti0TWm9rc8W
         p0izVEk+xR/VWfYYkg8a0mKET77zPnww56bF24gq9xlsBGIq83dcPgbRA3DFT4LPlzrm
         Jymcd0Y3A885hq+oASZtfQpiqdogDimeZ1aZFLbXRlfS7Ktlr7bia5q7NEcZHGqucYU8
         Onng5HuEnCfi3idFpNWWrD0+jfaBn4x+qBpV6bw4m5DHDJXgllISOX9ncp1VDq6Z5Tc7
         DGwYTVEYXSot/uR1yefdOtSxINcdxCHw8lzteMCtWdBdYlmjyUN8lltsTXRXWEZJWr2G
         0Sag==
X-Forwarded-Encrypted: i=1; AJvYcCUnvc3wsrRFSE+D6GdZvjCnsh/9EuyTxrqx8n0YBcV+pApVPCmlVuAhe7P5nsA5hnuLsE3rlEbS@vger.kernel.org
X-Gm-Message-State: AOJu0YxjROpnTtFidIBv2mdNWVF1CHiCoyxolqCUM1RO+iEfOtlN2Xa/
	PLMAyTQKzzuif4V2n+RE6HptbguEhCXUuS9pBP85eJpGpWaLTxTe3UNVoUT9qr7t3FXMZHOSCJ+
	LoOYF4IpzpIvj6yaPsoJeIWSj2W1uIlk=
X-Gm-Gg: ATEYQzzi3eeff/nAqR/4/jJl7GDC6k44OBORfhnOdvgIp/9TQyApIunn7u6lJVj0XDk
	yD6RujArD++4SF/LCXp9n4aYw4VOxbA1ZHV9WakE0CsfDccpRfjObPFQMFGldfY/Ftq3uPlqjYp
	KGnLBwCzsR1YuccsOw7diFLfKD3s/9kIG1qv4wLLl/c3JjAbVCTBAK2E/mFr2LrSYkLlEfBkQGW
	I2WK91hETMgcLWIzbBCbRCgu8rnxL+OhPhHhhjJcui4bXEyouJqVYDXz6+BCdlpSLfkoMxFv0LR
	KvKiWh8yjJXFkKffOP6vRLGhHKRdeuIZvsdvLSfomejN62na7A==
X-Received: by 2002:a5d:590e:0:b0:43b:4352:1bd8 with SMTP id
 ffacd0b85a97d-43b6428ba33mr631337f8f.53.1773948383714; Thu, 19 Mar 2026
 12:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318222953.441758-1-nphamcs@gmail.com> <20260318222953.441758-10-nphamcs@gmail.com>
 <20260319075621.GR3738010@noisy.programming.kicks-ass.net> <CAKEwX=MUrLtZAcmwqBau5GLnWQrjL7A_4tYrdZ4TQQaE+hsVkA@mail.gmail.com>
In-Reply-To: <CAKEwX=MUrLtZAcmwqBau5GLnWQrjL7A_4tYrdZ4TQQaE+hsVkA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 19 Mar 2026 12:26:11 -0700
X-Gm-Features: AaiRm529wWFONjiD2biQuzKZu-r4Xpu1F03-qQuQMU-V-fDEyZaMmWMBQx2xjec
Message-ID: <CAKEwX=Mp3=E_nVhFFvdyKWjHtdp6TB=edp9-x4OajZp6MPRwrA@mail.gmail.com>
Subject: Re: [PATCH v4 09/21] mm: swap: allocate a virtual swap slot for each
 swapped out page
To: Peter Zijlstra <peterz@infradead.org>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	corbet@lwn.net, david@kernel.org, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14924-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.484];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: EFC3B2D1A5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 11:37=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Thu, Mar 19, 2026 at 12:56=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> >
> > On Wed, Mar 18, 2026 at 03:29:40PM -0700, Nhat Pham wrote:
> > > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > > index 62cd7b35a29c9..85cb45022e796 100644
> > > --- a/include/linux/cpuhotplug.h
> > > +++ b/include/linux/cpuhotplug.h
> > > @@ -86,6 +86,7 @@ enum cpuhp_state {
> > >       CPUHP_FS_BUFF_DEAD,
> > >       CPUHP_PRINTK_DEAD,
> > >       CPUHP_MM_MEMCQ_DEAD,
> > > +     CPUHP_MM_VSWAP_DEAD,
> > >       CPUHP_PERCPU_CNT_DEAD,
> > >       CPUHP_RADIX_DEAD,
> > >       CPUHP_PAGE_ALLOC,
> >
> > > +static int vswap_cpu_dead(unsigned int cpu)
> > > +{
> > > +     struct vswap_cluster *cluster;
> > > +     int order;
> > > +
> > > +     rcu_read_lock();
> >
> > nit:
> >         guard(rcu)();
> >
> > > +     for (order =3D 0; order < SWAP_NR_ORDERS; order++) {
> > > +             cluster =3D per_cpu(percpu_vswap_cluster.clusters[order=
], cpu);
> > > +             if (cluster) {
> > > +                     per_cpu(percpu_vswap_cluster.clusters[order], c=
pu) =3D NULL;
> > > +                     spin_lock(&cluster->lock);
> >
> > This breaks on PREEMPT_RT as this is ran with IRQs disabled. This must
> > be a raw_spinlock_t.
> >
> > > +                     cluster->cached =3D false;
> > > +                     if (refcount_dec_and_test(&cluster->refcnt))
> > > +                             vswap_cluster_free(cluster);
> >
> > And this... below.
> >
> > > +                     spin_unlock(&cluster->lock);
> > > +             }
> > > +     }
> > > +     rcu_read_unlock();
> > > +
> > > +     return 0;
> > > +}
> >
> > > +static void vswap_cluster_free(struct vswap_cluster *cluster)
> > > +{
> > > +     VM_WARN_ON(cluster->count || cluster->cached);
> > > +     VM_WARN_ON(!spin_is_locked(&cluster->lock));
> >
> > This is terrible, please use:
> >
> >         lockdep_assert_held(&cluster->lock);
> >
> > > +     xa_lock(&vswap_cluster_map);
> >
> > This is again broken, this cannot be from a DEAD callback with IRQs
> > disabled.
> >
> > > +     list_del_init(&cluster->list);
> > > +     __xa_erase(&vswap_cluster_map, cluster->id);
> >
> > Strictly speaking this can end up in xas_alloc(), which is again, not
> > allowed in a DEAD callback.
>
> I see. I'll take a look at this. Thanks for pointing this out, Peter!

Hmm seems like we can just defer-free on the cpu_dead path, and that
should be safe?

Right now, if a cluster is cached on a CPU, we know that it's not
cached on any other CPU, and it's not on any other partial lists.
Maybe can call_rcu() here to defer-free it. Hopefully cpu dead is rare
enough of an event that we dont have a backlog of free deferrals :)

The other alternative is workqueue (with some careful rcu handling in
the free callback), but that seems unnecessary.

