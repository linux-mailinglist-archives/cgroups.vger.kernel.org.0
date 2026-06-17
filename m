Return-Path: <cgroups+bounces-17048-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uwg9K9u0MmrV3wUAu9opvQ
	(envelope-from <cgroups+bounces-17048-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:53:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C660D69AAFC
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:53:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=W+wL26Zv;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17048-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17048-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E77C5301E444
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A370347503;
	Wed, 17 Jun 2026 14:53:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFBA26ED3C
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 14:53:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707990; cv=pass; b=cMorfVahA5fg8u4HCDS+nT4yq+fQ104ufptiEFVCMA6gKFHebAmvQDHjCBOO+OpI8aiNKKS8hyNnklFCQ9sKFS2JRkNZndbjefz22MWz42nsWzhO67GwilL2THTgoDbKbNzvdCAjSL3GwHlHyR28VcycWoT/9Kyl4TECfKSkvzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707990; c=relaxed/simple;
	bh=imP592S/J1YQwMh8N5xD0EL+dcF6p17iby1WiuK/NnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsuEWDIF6IYSsLnsO8z7RJnMQ1Ve6u48SaBJDs1VgNn1U6jeDplqesjsIbROsaom1JDuCl/3DBICL5jbVj7tun2jf5bnT9lYAsaRitvmHL6anlbBuIng1VcyykpqFy6dtN/cDqdXmhp7ZZfadqL9LmYXOiEPPSZKEcGC38Z6gwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W+wL26Zv; arc=pass smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51765531803so311441cf.0
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 07:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781707988; cv=none;
        d=google.com; s=arc-20240605;
        b=b45+fQFsLkTxCr0N//ycdd6xdnFQ9axkVQcr0RowzH2I1OEMGsu7Qd//Nh53myvdld
         PVXnEqPQmnjN7MmkYKmWGJX0xITnjayi02XwZnnWZjrnmSojf2WxMjKTE1dc/gzH5lZ7
         A/kUtdp0BCS4GmTH6SqR+t5wmmM9qi3pqm8LHyXo7Spi6rIX+7iuByiYE63Sj+t5uzdL
         4wyvccLmkmN8qxZvPqBsAiNY0+2iaTzdPICVppyuUBAWoC0ub79cYDtn/pO28KcDXnZ7
         fMJ+I86IdW/IOsdFDkxNwhSXYXkksROQ9TT9hi4aEQjSC+BFS7E8ip/rvFYaqc7q8SsP
         6/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=imP592S/J1YQwMh8N5xD0EL+dcF6p17iby1WiuK/NnQ=;
        fh=EGDEplQfccwvmnqti2Nots9SfDeDqgqK93YxgelEUfk=;
        b=iV3P/uBLMtod/AQnKNLH9aJNNThjIJQiBdRc5jLnos9qYHE8V6mvIQkRc64iJXZdGb
         eT6i4uEKrbr15yjKVo3LGibXeatFTQgS6jh7186CEZCHNdaxyg/IcTzuF7Qeo8sPFG4b
         CGo5dEQ+WMOPL90k0c19bXLgL16lppsaekjN+Hg9UgDWCL1LxQNItKfAoi3UMEBS9SM/
         HBl6lfxOgvyTRQJykpymqPwR0D9SjlgVuaYMGpKKAVrAv/dpwq2FzzyuJq4RQoYY7XpA
         8EI+AUN+ZiG4f2umiebzIuWTIl2n2WQ0fmWanWMLw9PInm7YxR/iTIRxVkCVb8l0rbeF
         uj0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781707988; x=1782312788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=imP592S/J1YQwMh8N5xD0EL+dcF6p17iby1WiuK/NnQ=;
        b=W+wL26ZvjtEJB+dK5wIie24Mp+ksVcqmB+haX6Wx7GgpFnRrXyf4Nuzac/o2PY64IR
         zZVSMg+TqcriJcn5GmTs0hpVSVaRO42r3mJq4Ns9Qvi+bHnxopr+MUSPFvUYMIamqQxD
         fGOqDqbvAiPrZWtSF3cON7yRNNSgGrLl3uKwtb7H196EE7apvJwmBKdyEgOvzwm/mpaq
         amdHOOLyYvjje5KcRJ4HRQnbuHVR8dIAwnODC0g4icQxDHypftXloletq+t/S52ZwhVk
         Jrzyw0iQMimXDCfgoH2+BZ5lwZU0lZdeRVvMs4ktJG0edXUwexL6r9kPNLZSlTvHmSXT
         F0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707988; x=1782312788;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=imP592S/J1YQwMh8N5xD0EL+dcF6p17iby1WiuK/NnQ=;
        b=Ejs7Ss5mijQjHLDHDhEj+FxePCx9Ynm4Q0hGbE+sW/kle3BOhp2hSI9FKJmb6J1+Ub
         ZYdLVYwdkyKS6kX50PhXavGYwMmklROJ+ErFnrAZUHycjJfXY8+wV9yQImGG2gWZ1N0m
         nnBpvG6lcRN7BkLMKJ42GwFj488bDGkxLO37gJeUvNoK2dAXtNH+iFujhzyYI1nh9Kwg
         fJOLhSgig72QzxIpzkJN0s+tV37P74lVXXGAR5HiM8x7JYq1++yKwWR7n/hQOaGBLmB9
         rXDpChvJ9KDViRSCoNhadVUW0Z6LVMKwP2vX2KWsN2YXjeoxwqZ2jbA4b8mIjqsbKIwT
         BOZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/74Udpd4LiLF3gIqDPmJ/CXZwqsHAPA9O9YRo7vhMCPoC+MAOqhit/SDp9LU8COeBPdFxQEPc@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOSJfZEU4HbyWxn52JqtW3gdW+DbpLHsVd3p/DMM48ZfC726x
	6QFDu61zvNoad9uDvxAfhES3jWixRT/XriTeqqMSmOSRsEsMapZTUPMsa0EHV0G1zA3WIUs+xsQ
	yU0IR0aoDQWaqTj4puwZUN/u+F+cHwXUJwtkd+wHp
X-Gm-Gg: Acq92OFT0nuFSAGC7YpakF3oAwyWjzxMoJuPD4YWynoPYybxNuHj2gCr7Gq3OaTYCrm
	Ps/K4JUQwS9sEqbGhzgRJuLLpa70O13mZOH9EHuv98f+8q4m5qXlVEjGLYPgCfJb8lDGssxArEh
	NREfONFy0hv/hbYoRhgT3j9upNzlsmh1VPtRIwDuh4cLWm5t2AlGQnHev7V1hsEN/5dI5vtWu2o
	j9lueiyjyBobwm8yNdtK0ACPnh9u1grtxw5Rw7JfPbUwXguO2ShZjUMSYaHzGjDNhVTZaecd2dE
	1FJ+gyIM+LUnagn15Qtiy94sa3BBzJ8Ouu2IZw==
X-Received: by 2002:a05:622a:5884:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-519aa962ed6mr10795791cf.10.1781707987103; Wed, 17 Jun 2026
 07:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
 <20260615-slab_alloc_flags-v3-11-ce1146d140fb@kernel.org> <e499bab7-9217-4bac-848c-fb1472cd2c00@kernel.org>
In-Reply-To: <e499bab7-9217-4bac-848c-fb1472cd2c00@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jun 2026 07:52:55 -0700
X-Gm-Features: AVVi8CeovpdgMDaFWVo5H90cEy5_jKLmId74VoKLgJA87ZiYXZ9qXRIxXzrMQ-A
Message-ID: <CAJuCfpHLAnDUrxmVSNL0L-KCO8-dv8-r5ugPJ-naJZ6ox-7CNw@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] mm/slab: pass slab_alloc_context to __do_kmalloc_node()
To: Harry Yoo <harry@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17048-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,linux.dev:email,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C660D69AAFC

On Wed, Jun 17, 2026 at 2:36=E2=80=AFAM Harry Yoo <harry@kernel.org> wrote:
>
>
>
> On 6/15/26 8:54 PM, Vlastimil Babka (SUSE) wrote:
> > With alloc_flags usage in slab, we can replace __GFP_NO_OBJ_EXT with an
> > alloc flag that prevents kmalloc recursion. For that we need a version
> > of kmalloc() that takes alloc_flags and use it in places that perform
> > these potentially recursive kmalloc allocations (of sheaves or obj_ext
> > arrays).
> >
> > As a preparatory step, make __do_kmalloc_node() take a pointer to
> > slab_alloc_context. This replaces the 'size' and 'caller' parameters an=
d
> > includes alloc_flags which we'll make use of.
> >
> > Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-12-7190909d=
b118@kernel.org
> > Reviewed-by: Hao Li <hao.li@linux.dev>
> > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > ---
>
> Looks good to me,
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


>
> --
> Cheers,
> Harry / Hyeonggon

