Return-Path: <cgroups+bounces-16574-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2EfpNe7/Hmr0cgAAu9opvQ
	(envelope-from <cgroups+bounces-16574-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 18:08:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D16EE630122
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 18:08:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=r9C10OTg;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16574-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16574-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0BAF300E152
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA913F44D9;
	Tue,  2 Jun 2026 15:54:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E583F1ADE
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 15:54:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415684; cv=pass; b=MEBgmkzMHZ6PzIs/CC2p8u7TnK8c3Xk4ArLQnuKmfdv4ny7BRV2Snh7zseQKCf+X5/c9lljlac1NtkcM6fgjGWVbEAEXf3/d6ei/UdoZ2xoBaGg4wLIvkqnKYoi1soWpVule3pe6ucFNvpFKuVLyZPtCeMuRnxgTxeduiFmVf2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415684; c=relaxed/simple;
	bh=uv9Sy/kwsbhQqkAS4Zhet+9C0cGQwDE+yhgPZ0iyMCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9quizMEwHcqZc0VJr1cOr4AcGvAnC109PO//SLkjCExrNxpKvRHdUH4lBoLTOS/rRIpEf2cFXA2KSKdyaePSJWZ/077cluHbf+y7Zr1EfqrQNjrNXNOcNad2qcMUR3x/k5YIVDwzgJ/vWtBL0LwqnpuTmNoz1HSeoiauV1WhT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r9C10OTg; arc=pass smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso109340545e9.1
        for <cgroups@vger.kernel.org>; Tue, 02 Jun 2026 08:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780415682; cv=none;
        d=google.com; s=arc-20240605;
        b=AvT86rbo/Ht7dO4J8KkodP79MV4EnW+qN+1ltD11AseCXa+nfpuEXBBX4VrbMByr11
         xKlw7v9NZa250S72nLJ2Af3nCVmiAXZ1g6mzYi+9P2/Y43U6MW40wqVnlCnW8xmy5Ori
         Ffy5CPBBhfk+xuSm+erfugWJYI6X/n16GJCx3TFC+DQtoTelKEUnXOYrMYwWA08llcD2
         /dX0HWq6f/BSbt21Ge1n/Lu9q9mkn/tiVeYnWBeH6Ow4Ab0FfBtcNOW8KLie3yiv6umy
         bzooxUovGU+sV2c7ZWtqYWJEy1tmwJPfQdRwAngQZ7lYO9kWKda5Ijal7xewwgvP9nq4
         vSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1R1Ix/hNP2c7DmSyPCrvcGynZL8Qs5aPHoY+LWWhkG4=;
        fh=BsYpGTW45yGfFWU88E7h4To53TC+UZOlNehNEpRLtlk=;
        b=eBVBX5ori6BiVzAjAS7q+Nc95MAUWv1YLFBOBtTOexKKi4TXE3A+0aJ01xqwjBlfjk
         NpZNrFS1wAbH54kAPICmpf/6ibhKiT8SDm26AxSMOAccp/Y+yO+Fof4p79qY6l5lTF90
         pBpDsJT/b84Phv6jkOROzyyan+8tHBuZcCvH5njV7o6yLHyV6nE2Dqset2nO/7LYRw6w
         RxefJ1HdDyRdFNu1+Zla545v2/8beXc8t5MpAvlPdMzbPkssJRjw0CNNTaRmwNx0fBnj
         CQLktte12jIAGoqdWVdXh1y5vYXUqlWyB7BjK9gwX60OexSEk56/3uOjtD0tkxDQpssQ
         tsUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780415682; x=1781020482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R1Ix/hNP2c7DmSyPCrvcGynZL8Qs5aPHoY+LWWhkG4=;
        b=r9C10OTgSxnKjWCcHjPcC+mNsq0xKy7Ozk1R38OOFbFehZ+8V6iPcdoKkWf7kDf444
         yJj1/4x36RJHIsqGQw9kaV0ITPluinJ9VgYn/+iJMAuu609iIANZLUS2O8W9qtI7U/19
         9//meuOMjWYZ4UXDSt73vFRYq7cN50wVkbJrYWBveYCyAnQKEwHhA4o/eXxQKn6p6rur
         ASEd35m4rMBRC8/YSSoj4bA/Klpt7gGv48iuzP2fcENnIoJLauUwVaVdEzOoCMXfolcO
         64ujFypgd6zOKXE354ognlSLL7+N5axMy6OH2g4sPdPlI8+pz1qP3Y1hBoewNkuKHmym
         lEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780415682; x=1781020482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1R1Ix/hNP2c7DmSyPCrvcGynZL8Qs5aPHoY+LWWhkG4=;
        b=shPMDQjnnqhqFh/fzsSsdpFJ13UAx6QxvE5E6AgOMwzHZ/GlAZJLoCpHx9ndhRf67q
         J8C0pzXZwwYXvNPvNUSZV1yR4JT7C46wGhAfyUFaf3QRO+FDdN53Uuqm+wklmst50fnj
         BQHaoZYSGhk7YJ0dKiFTDPxGIOjgg2OsBFYA+RxooCPMjIQFO+VtpFnyrvwdCq6hx7gq
         7nag4/9Kddz/4q1JbzJ3ULvjqWfveXucCxsjjQTiwdjl33EiOmJAQ9YRVqncLmgG6LxT
         d3ZCzpUtMTz7dqtpC9e8uXc+CBMCFFlgkG34vR+A53Aa5FZCETpXx0FeVYj+TA77wIJ3
         wxQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FyBXmgb1onjX05lcvCvR1bBzUZ50N8+emCr5OhLJm17e4+SUvEG9Gy+52u4msDZ0EM2GoNFtX@vger.kernel.org
X-Gm-Message-State: AOJu0YwsmuN/ZVHlkDZNrUTMDMHRZD9Y49y2BkZgMfanQCweZ3CA+/ar
	pfTVSEe+30b/zfVNKdL2N6jlWOEnZQ6ykg6LoxJBK97fa0I7h3YrqKDWyM1iu3meA9X7XzzLxt5
	dsS1Tf6RftD49tb3AzwBlMOq5IU+mBEE=
X-Gm-Gg: Acq92OFSmyz6YqyT1H+gvA7cI08eztSmyfRmRMJ2u732TOpcmRuOUflA6Ao8jTf+GCw
	zPUZ/suJhvOU2tsr7fiyz3e1Kuf2eHW2zHvw2rzcVd4Fl2E0MbagPTXuGRH+NL4WSlOhedoAHeV
	vHAMkPsAIJIUBHL3NVHLIYfmloUKAF6ktmaYwDRZqoxefXDJU7UjAMxcgRGqTVV3KLpjRg73fyW
	Tw6vfcnYoDTgHXtkeu0hTMbc2ldMGlNNH1tJucIhnGhGqTLxLi0JwliyP2SsKcRYmMqUPfYoTNd
	PpkQN+3Ax6bXsGwCqdUdSx9o7H5nAfHccuyft39H97sQ8zu5jIsNoyVwaFoL
X-Received: by 2002:a05:600c:3f0d:b0:490:6e11:c303 with SMTP id
 5b1f17b1804b1-490b50800dcmr5883175e9.13.1780415681566; Tue, 02 Jun 2026
 08:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
 <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
 <CAKEwX=NNNf0KCZC0ph7VRW0gjnbXd4W5NKEaHM4XzPdN03Ek3A@mail.gmail.com> <CAMgjq7CT0ccCnzmpRGjTGPnNEn4eK==5A-OFbr3+p465dQMH4A@mail.gmail.com>
In-Reply-To: <CAMgjq7CT0ccCnzmpRGjTGPnNEn4eK==5A-OFbr3+p465dQMH4A@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 2 Jun 2026 08:54:29 -0700
X-Gm-Features: AVHnY4JuNWTHfiBCJhA05cKPBhtFvToyOb40WTAxv5a1N06Szobh-7Laznmn538
Message-ID: <CAKEwX=M3WAkSY=Zd35dEuQ6V3ZiNR02bKAN_DnCgVr69w9=0sQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Kairui Song <ryncsn@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com, haowenchao22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16574-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ryncsn@gmail.com,m:Liam.Howlett@oracle.com,m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:bhe@redhat.com,m:byungchul@sk.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:chrisl@kernel.org,m:corbet@lwn.net,m:david@kernel.org,m:dev.jain@arm.com,m:gourry@gourry.net,m:hannes@cmpxchg.org,m:hughd@google.com,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:lenb@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-pm@vger.kernel.org,m:lorenzo.stoakes@oracle.com,m:matthew.brost@intel.com,m:mhocko@suse.com,m:muchun.song@linux.dev,m:npache@redhat.com,m:pavel@kernel.org,m:peterx@redhat.com,m:peterz@infradead.org,m:pfalcato@suse.de,m:rafael@kernel.org,m:rakie.kim@sk.com,m:roman.gushchin@linux.dev,m:rppt@kernel.org,m:ryan.roberts@arm.com,m:shakeel.butt@linux.dev,m:shikemeng@huaweicloud.com,m:surenb@google.com,m:tgl
 x@kernel.org,m:vbabka@suse.cz,m:weixugc@google.com,m:ying.huang@linux.alibaba.com,m:yosry.ahmed@linux.dev,m:yuanchu@google.com,m:zhengqi.arch@bytedance.com,m:ziy@nvidia.com,m:kernel-team@meta.com,m:riel@surriel.com,m:haowenchao22@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D16EE630122

On Mon, Jun 1, 2026 at 10:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Jun 2, 2026 at 12:22=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Mon, Jun 1, 2026 at 8:56=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> > >
> > > On Mon, Jun 1, 2026 at 12:34=E2=80=AFAM Kairui Song <ryncsn@gmail.com=
> wrote:
> > > >
> > > > On Thu, May 28, 2026 at 02:29:24PM +0800, Nhat Pham wrote:
> > > > > III. Follow-ups:
> > > > >
> > > > > In no particular order (and most of which can be done as follow-u=
p
> > > > > patch series rather than shoving everything in the initial landin=
g):
> > > > >
> > > > > - More thorough stress testing is very much needed.
> > > > >
> > > > > - Performance benchmarks to make sure I don't accidentally regres=
s
> > > > >   the vswap-less case, and that the vswap's case performance is
> > > > >   good. I suspect I will have to port a lot of the
> > > > >   optimizations I implemented in v6 over here - some of the
> > > > >   inefficiencies are inherent in any swap virtualization, and
> > > > >   would require the same fix (for e.g the MRU cluster caching
> > > > >   for faster cluster lookup - see [8] and [9]).
> > > >
> > > > This could be imporved by per-si percpu cluster. Both YoungJun's
> > > > tiering and Baoquan's previous swap ops mentioned this is needed,
> > > > and now vswap also need that. If the vswap is also a si, then it wi=
ll
> > > > make use of this too.
> >
> > Oh and the MRU cluster caching I mentioned here is not the allocation
> > caching. It's the lookup caching, basically to avoid doing the
> > xa_load() to look up clusters for consecutive swap operations on the
> > same vswap cluster (which is the common case with vswap). For v6, it
> > massively reduces this indirection lookup overhead. Performance-wise
> > it's an absolute winner, just more complexity (because I need to
> > handle reference counting carefully).
>
> Ah alright, that's interesting. And I think we can keep things simple
> to start, since sensitive users is stil able tol use plain device this
> way.

Of course. I'm hoping vswap-on-zswap will not be too terrible at a
start. We can then optimize for the swapfile backend case later.

>
> BTW maintaining MRU is also an overhead, I'm not sure if the lookup
> pattern always follows that?

Yeah I had to be a bit careful in v6 to make sure the cache (and cache
invalidation) happens at the right time. I've had this idea for awhile
- there's a reason why I waited until v6 to implement it :)

For instance, when physical swap allocator runs out of slot for a
cluster, we try to reclaim the swap-cache-only slots. That involves
taking the rmap back to vswap layer, to check swap cache and swap
count. This is a very random pattern, so it does not benefit from this
lookup cache, and in fact invalidates the cache :) So I had to add
some hint to avoid going back to the vswap layer to check for
swap-cache-only state.

>
> > I also just realized we'll induce the indirection overhead on
> > allocation here too, even if the cached cluster still have slots for
> > allocation, because we look up the cluster (which is basically free
> > for static swap device, but not free for vswap devices). Might need to
> > take care of that to maintain vswap performance (but it will then
> > diverge from your existing code...).
>
> That part should be indeed coverable by the si->percpu cluster though, I =
think.

Yeah agree - we just need to be a bit craftier with it. The
fundamental problem is in the current model, we're only storing offset
and si, then look up cluster based on that. But for dynamic vswap,
that look up takes the xa_load().

Once we move to per-si per-cpu cluster, then I think it becomes ok to
store the cluster pointer directly, correct?

The reference counting needs to be carefully handled though. I think
in my old vss design I did something fairly silly - just hold a
reference to it while it's in cache, then add CPU offlining handler to
clean up. Not the end of the world I suppose, but maybe there's a
smarter scheme.

