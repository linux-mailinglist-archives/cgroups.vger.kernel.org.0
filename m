Return-Path: <cgroups+bounces-14923-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBYSKJhCvGlBwAIAu9opvQ
	(envelope-from <cgroups+bounces-14923-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 19:38:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0062F2D1242
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 19:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E3F6305366D
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 18:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DE732937A;
	Thu, 19 Mar 2026 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvSG/1SJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE772BD5A7
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945455; cv=pass; b=pDG3u1QV7If8g4XPtuOxWBVRnYE2nC5QvtoGI9cQu5XXREMnb8mmWo6UVuXBm7bj6DBjImpvMgnZIjgafbjn+0vQyI+VmH9RFB61Ez1Mm+KuCiHClajVD0QiXgJKs1KjU4LXIdq64InQFNO9i0+8M5Yx13dlUNGN5r2vvKbpl5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945455; c=relaxed/simple;
	bh=Ljd1nDUnqT7HjpseLLlArUsMFAua4xKP9JZ0zvMVBtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bY4FAX2pOMXVdzdE0jMllopS8LSlscHMtRuHjbqMDCAi29cAfay431YZ/OaDzvQXVzJkaO838I0uOaKK7jn50AZH4GTmtxPiiYzhPxeUGhC2/jaJjHKOTjElpTMLjNAhQS3qIBRcxJbzmRp1hK3D7mEfHt6+Hz1l98T1qE/ESgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvSG/1SJ; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b611274bso558417f8f.3
        for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 11:37:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773945451; cv=none;
        d=google.com; s=arc-20240605;
        b=QbHGVoLZszHx9p/7j8srRXck0WrsRDJ73eyjSev0HdODGG8AIj+Uib0eKEzL7ucAQ0
         94PtMpX4uM5XDNEh7B5pBj+s25iHH11hIxpqcKnomKLMxiF70puqUKmOiVapKxZy1/oZ
         p84Ur3ltRuuEOpdJunvTflFHdjtw5AHdzArWvOYDiJ0zCMECkjhFE+QSdjcwgTJ2cXUA
         Q6SZIvv80KiIUJE3Ke0m2mReSZHxpXNfBRtSJWdzSS/Og3Gc7ttURXttDTWLOZL1wEk+
         HTea/jQPm7S9NmO9AAfWc+V5dWb8gyGlmOhTTht4Po4vgtht/NOqMXfVQOCS2gsj59sV
         RJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=frA7u7Xc3APzc2EM7Lp+OpzxNxJLgzQFv8DZjhDK9GY=;
        fh=JH1Ct46g7Gz05wvihBV61o47H0C/+ANaLuRNdTOl7IU=;
        b=Yf3ar4tK2RwUCXNkSwSui3e1PbXilOdgnWWq/D7BA7H0QlbkOJfDOmHh35rcvKIZtR
         8acxqA1EYkWyNXjfgq9Di4T37odHoFyytVuHfPcybvzeobEykAg4PjwWSTqAwIf0L66Y
         tOVPmqmJP3/Q+zztlckG2piiASxFqzM4Qqy4n8rkXImPkdWDa2ng9tF1qML1YGItt+kB
         DogbdxQISX08CEfP5HcYQhg08+xasseaBU+VoF05hew34qoToVSta3fAtE5sKW+zRAnm
         hmiy7rm2FkbXkgxOHD2VpgjsWy1b5EKtwyXdDqXmJTAyeKjaZ3BNjdnXL6fnUuRqFAVx
         UHUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773945451; x=1774550251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frA7u7Xc3APzc2EM7Lp+OpzxNxJLgzQFv8DZjhDK9GY=;
        b=gvSG/1SJ6SqTkBbQiLzGcjeUi/b8T6RuyxthouoknB9X5HjwTnyCOqJkos2GEyxwC2
         O5A/j2ocmdwv6LLSD5jGmu41aG+ZUfAt/S7SsqCacRSRx2kSkecsLq9JdkCnV5tPrRzV
         JL315xliybXOb9XI68uVMZAN508touHpDjz3J9JFdhagqagqY7o+RhFlOiAEeSVexIrc
         IAa3u+d73+ohPvvIyU1EsCfXwRl9L4A7x8kS5581txCKQ3UiIMcL2PDWuQw2zEOt/Pwj
         q8gAihaIMbfh7X6ZVX0IkJ2gfKEU+mWpOakEv2dNkIvbXI/0zMG+pL9pZCCpQt7o6twd
         uM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945451; x=1774550251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=frA7u7Xc3APzc2EM7Lp+OpzxNxJLgzQFv8DZjhDK9GY=;
        b=KbuP7lV8HXgh05tyEcdeY8CuAbnmQzFS3Dz/y5dDGdLo6OpRsZibsSTD/LlW0MPEsH
         oYXuOwOeX89O1SZgUwxyYDdy7LLUHWrUrN3uf5Kg6rkSTWoi7EhxREbyjNdV/9bX+aUf
         v1sEaP+oznMo3AVICmqkrxjydpHdhu+FkO1HlrazxCfn5E1h9mT/BSiCAZH4JWcXwuTE
         LMRd0VK5ad6MvrR3KpbzmL9tgE4bBUbWmXZ6PjWPzM1ns65q6hiCHkGPZXC8ftIkQb4q
         s2VTvUin90rvCLANCVB3hicbDp+ukq+3Ts3JquWmpDQl31a+eADtLBXECJkish/Iwg/L
         a+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWb9487aA0WPGmDGH3czl5dmDimCuChBkpRKkKAhKSOSftvs0sajMlTAl4VVm9/Jm7nMqnsGHQy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EphYC1wewRoXTNN27UPO2klyts9Jin5/MGAszMMM65izs8oN
	eawY2IAGVZoitLMWL6VdygBRIgLYQ2dHZ1m97oMIi+JzMcpkXmLz66e8gBFYTlxI8/n5sQ5Fgg9
	ZvTSsctqN5wEGGubeS44lBm5GZ/hPlBc=
X-Gm-Gg: ATEYQzxIbst5A4YbHp2pd4MGilGaCKIk8mZhjlgc+NoZlamvtgCoAnZKhuKRU81ps90
	UzYPn6KPkiUnzRWKQKgw0/bmAvUgeRzRlxf/CDbhsTdepsv6efexZCMW/P8uQDFGgHRjmGmMMRX
	3hpqO+ifw+FOb07W2dTXhL+8RwFURahFlttWckuBvdgdaFmDeOr5sPVO9Hi6dQFgZ5RFWLilBwE
	OuM1jvg3YhD8AH2HMY4yyELdPWjrQ7v7RInz5c0CUQsl6Std/2qblhi1dujVjwDWxIF56CyZxfT
	QcZwFIC23OoChiGdu3JywToluy8g4PHXOqROZ5M=
X-Received: by 2002:a05:6000:3113:b0:43b:5003:e300 with SMTP id
 ffacd0b85a97d-43b642814fbmr636579f8f.43.1773945450700; Thu, 19 Mar 2026
 11:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318222953.441758-1-nphamcs@gmail.com> <20260318222953.441758-10-nphamcs@gmail.com>
 <20260319075621.GR3738010@noisy.programming.kicks-ass.net>
In-Reply-To: <20260319075621.GR3738010@noisy.programming.kicks-ass.net>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 19 Mar 2026 11:37:19 -0700
X-Gm-Features: AaiRm50Q6KPbZbD6bEq0DQLWi-DLG4OekR5us80lL4mbKl_agLxOnXc4Kgcmx4Q
Message-ID: <CAKEwX=MUrLtZAcmwqBau5GLnWQrjL7A_4tYrdZ4TQQaE+hsVkA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14923-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.573];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0062F2D1242
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 12:56=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Wed, Mar 18, 2026 at 03:29:40PM -0700, Nhat Pham wrote:
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index 62cd7b35a29c9..85cb45022e796 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -86,6 +86,7 @@ enum cpuhp_state {
> >       CPUHP_FS_BUFF_DEAD,
> >       CPUHP_PRINTK_DEAD,
> >       CPUHP_MM_MEMCQ_DEAD,
> > +     CPUHP_MM_VSWAP_DEAD,
> >       CPUHP_PERCPU_CNT_DEAD,
> >       CPUHP_RADIX_DEAD,
> >       CPUHP_PAGE_ALLOC,
>
> > +static int vswap_cpu_dead(unsigned int cpu)
> > +{
> > +     struct vswap_cluster *cluster;
> > +     int order;
> > +
> > +     rcu_read_lock();
>
> nit:
>         guard(rcu)();
>
> > +     for (order =3D 0; order < SWAP_NR_ORDERS; order++) {
> > +             cluster =3D per_cpu(percpu_vswap_cluster.clusters[order],=
 cpu);
> > +             if (cluster) {
> > +                     per_cpu(percpu_vswap_cluster.clusters[order], cpu=
) =3D NULL;
> > +                     spin_lock(&cluster->lock);
>
> This breaks on PREEMPT_RT as this is ran with IRQs disabled. This must
> be a raw_spinlock_t.
>
> > +                     cluster->cached =3D false;
> > +                     if (refcount_dec_and_test(&cluster->refcnt))
> > +                             vswap_cluster_free(cluster);
>
> And this... below.
>
> > +                     spin_unlock(&cluster->lock);
> > +             }
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     return 0;
> > +}
>
> > +static void vswap_cluster_free(struct vswap_cluster *cluster)
> > +{
> > +     VM_WARN_ON(cluster->count || cluster->cached);
> > +     VM_WARN_ON(!spin_is_locked(&cluster->lock));
>
> This is terrible, please use:
>
>         lockdep_assert_held(&cluster->lock);
>
> > +     xa_lock(&vswap_cluster_map);
>
> This is again broken, this cannot be from a DEAD callback with IRQs
> disabled.
>
> > +     list_del_init(&cluster->list);
> > +     __xa_erase(&vswap_cluster_map, cluster->id);
>
> Strictly speaking this can end up in xas_alloc(), which is again, not
> allowed in a DEAD callback.

I see. I'll take a look at this. Thanks for pointing this out, Peter!

