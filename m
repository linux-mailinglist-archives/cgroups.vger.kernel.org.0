Return-Path: <cgroups+bounces-14932-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO0PE0qIvGlk0AIAu9opvQ
	(envelope-from <cgroups+bounces-14932-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 00:35:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 481B72D4307
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 00:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 418E530200DB
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 23:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC4F15CD74;
	Thu, 19 Mar 2026 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntpMk/SX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32359345CAA
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962893; cv=pass; b=qccTKNbUKJuyWHxfmczk8wsNPrFKjRqVIgfu4wRfMnmVVN1zytx+NctHZV9wfaOLDIVX72CVjk29K3UA1knIdcXyWB832eqazKnA5FwTMcv045piRx0LzbwSEHr3XenafmIzrn+JZwJB1TJjrLJ9396mS6cilX3j8EaD9razukA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962893; c=relaxed/simple;
	bh=/dvPkx/pvBcotP6nSquXBwzk1NIgIOFThsc2f/pMPDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaeNe9UJj03FafM7/xyhlkQkhkHXdUp5huft2Ipw8wN201E4zrcBtR8dCXOG//iC6K3GWL3X0ePblRWqtVoqjHDgv5W9cl7e6tc84P7d58axrs1nCjNQ0AfWwbwolGCkPfnHyfyvlhK68z62+oscFfaY6V0BS58q7brPaL2G7BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntpMk/SX; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so1427266f8f.1
        for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 16:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773962890; cv=none;
        d=google.com; s=arc-20240605;
        b=OFnbKXAaFzxw68TaTn0O11spumfDQXU+310rK1/ItzwYDi80MhYssjKSHAYI5QpQwl
         fvEi/3mK+50QbamtBnFf8gwvNs6hn66h8V8c01kjbyZI1GhgBAyiH2dNrFQr/rnp+KQl
         E+p/NHqb3ofsgF5r9AI41dmzQtyKCH5LWXfoo6z2isK8Ek+LSw3ej6dN/7kg2i8RjrLW
         6prInNyp0pDwCdBz47LKNUbKSGB7P+bCZMcpTO7sFE/4Iq0xyB+bb3iw7JAHSg4gMkTr
         J5RZdbpzT4HEzjhcUKzGu0mnJv+1zEQKOTbbXcLIiYffsiqwmBx6msQAEoWvFlteavyy
         TERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K9OWBtdlQRn2CWoGv55axZFQst3AHYCAYnvEd326GJU=;
        fh=lc+l4WLdJZdpdFMa2+Ow09ipD9/4Z0ikKMiUfP1RziU=;
        b=JjSCBok9lPylQBCxpNfZMQK2uiVZaWVbPvC+32V0tsrvxTiZzgAi6OWFqjWXr18gQi
         mfqbGrIa0NFEXYXTHRGAEjuQSuI1qBL9p7RjwHdJdtHYXow/Be5JESIQcL8E9Y7J2Zlm
         KJW3q50HTx2TDS0/1zZ2vJKipCRysu9yfUSBPb2NDotjdp07ObG8cBRiWoGbxDyvjJIj
         jubVJw4DVzGPz2XC0gLtIne8r6AogiSfW3uLJHFHJFZozZoWz7o5E+kNsaJaDzn6tUXy
         MqxMJALKusQ8qYvxeBttenEd2q4srveHJ50sF8x76S7REmOOXOst5LRI7HBGXpFSOzhb
         OeTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773962890; x=1774567690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9OWBtdlQRn2CWoGv55axZFQst3AHYCAYnvEd326GJU=;
        b=ntpMk/SXT8L/BMfU1kroeGlMTpVflTCl85zJA1Ri/XLJcf5zwibQhB7rcirXdez8aJ
         9FqniLfYLEUBkzCdkHfs20VKBtyTpFgEVZwYFnwhj+/BA54+PPBfxqYLV3naEiuxLYup
         dq75/wic9EmRt3OOCYK6k9NjnYowMCVRQf84j2SmB4JCDhImb8Sic84cEqsvsWX2Av4V
         rI6NBPbw+SKY3BlDHA/L6VOf/HvhwhlsV1aqUe8otDybTcam0l+Jk+O038pKW2qCDgjh
         Xz0cqeBA4naGv0AvPb1hPZH0nymqjUj84/MK/YGsGFnWaqUxVZpnRTZTxwqvaK969Nc8
         DTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962890; x=1774567690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9OWBtdlQRn2CWoGv55axZFQst3AHYCAYnvEd326GJU=;
        b=TggNsuL/yI6f3tw1OnU1ZAQMCWyCjI7V4iHTi+YGJizzx3A3L7+A69mSrSkNqWGjPi
         HVRa15ucTjB/3IGm1Z0SknsRD5WTSqZMwRK0tGu8dCu+TuHiazHtEhmP6Zu2047CLMQP
         bma0Ev2C5clWmiZlw/vIVoBwuYJfUaBidousy0ZKTht0VF8tJYJM/9W9wyKALLzhXxUu
         pnOBMIywjr/uMFwVhw6wKco+5LgaxycdFhDKNHCfHwvHhe8FfPKhoVLUUDlvO1LuLFlz
         pJhx9yxlZdizHE8jfVPaQnmbpBWYw9ohI/vKPKZG4jsoYDOjOpnpHTmG8IhacrKkIHDU
         GuQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy+IJiEdDnCYy7VsPOczA+zXyb981XQ8OEHFgeuAGrr9Y9cE6uY9m6l+7+lHif6ya1lGHgYCYf@vger.kernel.org
X-Gm-Message-State: AOJu0YxkseIGpCQ0mqIaKgHJ6RsGkiFJTiL7cY8Tn1GzSNiaBa55PR7o
	oR63Nj8XE7gSFrBUOMciOFl/iSc3IoPJTM+GSXcgMsmBUeknl8pahNvUQ8/qgh8wyg0pEs5bcGq
	d/iF9XYOgLlRzSaqDG2DdbcyKbT7ozLs=
X-Gm-Gg: ATEYQzwjnfvLiZa3QbCGNfRD+mROWyzx1hYzn0T7qD/52mGTJn6FCfNgTKqKwb7fW3n
	mBIzGZAmNHU6byIm/Ei6wJ8qW8TDIRM+1z2Ev4uPMr/StLbif/UwYLHZFjK1OxW1Nk/OaC8nWD3
	DzO1XN9axFlmuNYVveCNA57GVquZqxYwdGpkgPXk11VLLQ49AtlCpoFQOPDrYdDPMbCAkeqJDcP
	AaccnDVm1VSYS4hU+Z/L+0Ge6xkT7MfzeRn+h/76GxkBpdnfwp5Dtqq4tIqhRYwl6ix/r8stN9E
	Mm8GgJ65vrPcL8ik/QO6fHvmJmsjNW5Fdz11Y9k=
X-Received: by 2002:a05:6000:420c:b0:439:c62a:6dc2 with SMTP id
 ffacd0b85a97d-43b6427973bmr1895992f8f.41.1773962890359; Thu, 19 Mar 2026
 16:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318222953.441758-1-nphamcs@gmail.com> <20260318222953.441758-10-nphamcs@gmail.com>
 <20260319075621.GR3738010@noisy.programming.kicks-ass.net>
 <CAKEwX=MUrLtZAcmwqBau5GLnWQrjL7A_4tYrdZ4TQQaE+hsVkA@mail.gmail.com> <20260319210319.GK3738786@noisy.programming.kicks-ass.net>
In-Reply-To: <20260319210319.GK3738786@noisy.programming.kicks-ass.net>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 19 Mar 2026 16:27:59 -0700
X-Gm-Features: AaiRm51gvauVsANsKDMAP1QUJ1JVBGH5RQXhUw4QEOuff8EZUUd-LXduXX7csLg
Message-ID: <CAKEwX=N_oAjYy3pKzXG+oq9arhNrmPVBm6gvVC_Hx2Utvjfr7A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14932-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.577];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 481B72D4307
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 2:03=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Mar 19, 2026 at 11:37:19AM -0700, Nhat Pham wrote:
> > On Thu, Mar 19, 2026 at 12:56=E2=80=AFAM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > >
> > > On Wed, Mar 18, 2026 at 03:29:40PM -0700, Nhat Pham wrote:
> > > > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.=
h
> > > > index 62cd7b35a29c9..85cb45022e796 100644
> > > > --- a/include/linux/cpuhotplug.h
> > > > +++ b/include/linux/cpuhotplug.h
> > > > @@ -86,6 +86,7 @@ enum cpuhp_state {
> > > >       CPUHP_FS_BUFF_DEAD,
> > > >       CPUHP_PRINTK_DEAD,
> > > >       CPUHP_MM_MEMCQ_DEAD,
> > > > +     CPUHP_MM_VSWAP_DEAD,
> > > >       CPUHP_PERCPU_CNT_DEAD,
> > > >       CPUHP_RADIX_DEAD,
> > > >       CPUHP_PAGE_ALLOC,
> > >
> > > > +static int vswap_cpu_dead(unsigned int cpu)
> > > > +{
> > > > +     struct vswap_cluster *cluster;
> > > > +     int order;
> > > > +
> > > > +     rcu_read_lock();
> > >
> > > nit:
> > >         guard(rcu)();
> > >
> > > > +     for (order =3D 0; order < SWAP_NR_ORDERS; order++) {
> > > > +             cluster =3D per_cpu(percpu_vswap_cluster.clusters[ord=
er], cpu);
> > > > +             if (cluster) {
> > > > +                     per_cpu(percpu_vswap_cluster.clusters[order],=
 cpu) =3D NULL;
> > > > +                     spin_lock(&cluster->lock);
> > >
> > > This breaks on PREEMPT_RT as this is ran with IRQs disabled. This mus=
t
> > > be a raw_spinlock_t.
> > >
> > > > +                     cluster->cached =3D false;
> > > > +                     if (refcount_dec_and_test(&cluster->refcnt))
> > > > +                             vswap_cluster_free(cluster);
> > >
> > > And this... below.
> > >
> > > > +                     spin_unlock(&cluster->lock);
> > > > +             }
> > > > +     }
> > > > +     rcu_read_unlock();
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > > +static void vswap_cluster_free(struct vswap_cluster *cluster)
> > > > +{
> > > > +     VM_WARN_ON(cluster->count || cluster->cached);
> > > > +     VM_WARN_ON(!spin_is_locked(&cluster->lock));
> > >
> > > This is terrible, please use:
> > >
> > >         lockdep_assert_held(&cluster->lock);
> > >
> > > > +     xa_lock(&vswap_cluster_map);
> > >
> > > This is again broken, this cannot be from a DEAD callback with IRQs
> > > disabled.
> > >
> > > > +     list_del_init(&cluster->list);
> > > > +     __xa_erase(&vswap_cluster_map, cluster->id);
> > >
> > > Strictly speaking this can end up in xas_alloc(), which is again, not
> > > allowed in a DEAD callback.
> >
> > I see. I'll take a look at this. Thanks for pointing this out, Peter!
>
> Oh, I think I might have confused DEAD and DYING here. DYING is the
> tricky one, DEAD should be okay. Sorry about that.

No worries at all. Thanks for help taking a look - the other comment
regarding lock-checking still hold regardless, and will be amended in
the next version :)

I'll stare at it a bit more while the context of this portion of the
code is still in my head.

