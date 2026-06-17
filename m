Return-Path: <cgroups+bounces-17050-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +oGlLH68MmrQ4wUAu9opvQ
	(envelope-from <cgroups+bounces-17050-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 17:25:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4B569AF89
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 17:25:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=KiAsoKI1;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17050-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17050-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 754E93088BEA
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6595F477E33;
	Wed, 17 Jun 2026 15:08:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F046AF2E
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 15:08:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708920; cv=pass; b=iJA33rgwEtIFewLA15i632eFgXeaXH+PEIjjZxVjm9BuVq/i23iCltMCCDrQlQ2nPiyFwI99flhdNBbfLqMRaKBmb0qoYkTnTrBYkNkXJRaJN6j1sLV3k1WiDc26EQ+uj6/Pe0bUSGuIK5AKFVNDeT4XgpCeWXkVWL8M0oHuZDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708920; c=relaxed/simple;
	bh=ZD/FSWuKNJJ08prZKbDUnd0quD3P3zFz0PHA1h04GHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMaxHs3vs0EN41z2c+LHj2A0RfDZ2hQmnId/qbR9u/A1JoShN8SxnZngYyPcn6eD3NjL86kSwVV1TwIJbemEvt5lnp87wExviuPcNGHI2yUrJozGTjXBJumhBMb1yUTXu3zYmYAlGGd+YxRphsRO3QTRNzbYq4JsjJTdCgu6aF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KiAsoKI1; arc=pass smtp.client-ip=209.85.160.179
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51765331535so277161cf.1
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 08:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781708918; cv=none;
        d=google.com; s=arc-20240605;
        b=GO6aYm3G90sciz65zcI3KXKABgVaVZ4kEhD1MKtlYIaUCxadEIGEJImZ0FScxZ/9LQ
         Encgh7q7XjbiMfcsdkkqeqxna7taS5EPFXYWn7gxbsUWN30RCYEmFUNQfml5Ipw7KePY
         DbvIkuUlo7fvqkC+4W1uC8lIMPk/r/8XWFM0/Rt3AX8JyYUC067wfM/CJcsX+wZlbfRO
         sal5KkVTbthyiRP7sU6Ke6PlWDsJJpYsaLoDc5dq8dQEZtyf/qrSWz0hy/917XYJ5fds
         kIy/Mhidq4qDzmMJWNvbft1IlCgT269rpAJGV5brQBJd6hCaylLwyLF7K19UDnwCGaJ5
         WkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H9tseRqnP7TDkio6KWr0QuA9aNrzwe8EnrwXOovFL6Y=;
        fh=ITck1pjAqBFfkSDevrbjBuBmVyeH9TFK+mBq+JhFaxI=;
        b=iNaXvfYAGDzcpc5lcAWT3TgDAUJup6i0xf/U/4WeXylz/QRErgKNb3CJnbTaGQwf8n
         hCpFn2R/ESr8TlTScz64DxX3QOtreU/KU9PzCOUphrNIc4w3JD73Lxd8rf7mfE8jQyCU
         CIu1wfqmBOBBC6sV3LnL5UrE0hm2jcmgqzmpPXlG3dVbpMNppnuIVi6bghLAFEWVorXw
         8/50pEuoK4Hd+UrqYizx3VkrXESIoMULasmRiGJI1zdngtMf/ooQcJ0feBZUqB2EH0DS
         ThEKAEqWVlfmetOwNLQGdYbScJioSPsvgpT4eu1Ecr+/Kw8H7DdeHbasFLgRjPLZVUqI
         IomQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781708918; x=1782313718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H9tseRqnP7TDkio6KWr0QuA9aNrzwe8EnrwXOovFL6Y=;
        b=KiAsoKI1DzVBWrRt34M+lUgO/tGLTynUWHQc3rcTw6cqZwfpodE/L8qqTVTkizDe9J
         C20X906j+jbfYjfPUSfBEuykEgQ0SPxZai/YRy4+q90PCnm2mF1/20fsmqT0iw4qhOuS
         jKq3Ubac06IHW5T0mJknSZJTjwb+naUqVyaVgHJH0MiAvuWGOrDnBMbuhav3sqpctVW7
         kt79LmTqU37LQCxsQybQ7SPMre35wIi/qxDlzSZtXH7oYN6QbfPmDlbCyqQwHb/KiTZa
         u5fMmEjMp2B2jgsI8YfbYQnSeBp6iUmC4sRRlH9zAbXRERYaZS3mm5qRnL8gv/cfet2n
         PUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708918; x=1782313718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9tseRqnP7TDkio6KWr0QuA9aNrzwe8EnrwXOovFL6Y=;
        b=UGFsUlw8j26v2oJFexelII/puF5qI2N4+Z43p871oHd1/w2HHN5o3lTBWM3qH5Fgrv
         B0gO11FkmEeAA9wl2XD8f6RZrMbfoEuPMzzdtV57lJnVRAOTTD3CnqC6GQy7gFo81t0J
         qntFec6n3xydXM7+H1kxD8qA1tGbyS13lRc/T1noJhBtorqDtqejGlrC4RYFt1iMYNwX
         xUF+eE4UkrzxckGEgq7QbqrVjWyHmmeJY7y6mQZ7pasVSrck0ofJOh1/1lSBYqW06fvS
         3YeeNQ4lu1T28Vq6YgsdJZFybOvFH9S4T9DsNNY74439nqOOiWJzZRMvoBB8sec+aACy
         SRew==
X-Forwarded-Encrypted: i=1; AFNElJ+JikuO3hjmBamFSXfP1uV/BpS1uK2hA0AXoeH7svcUnNCwF1S97AC5ovnbDHRSJddk5WA3CtQt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyutc9xl02zOan4MBNVSMl0rHr5OWJas3frqgKAZQJE0r+10365
	/jA+xR+fJYA1gEKVYXacEg2y49BkPoX/s2DIT+Csrn+4bWhv3612jyID0ku4Kc82USe5SyNzQ7m
	5suA18FoioTApd4g1D8zRNLHeqPDhHALFIZoOUOan
X-Gm-Gg: Acq92OFZEXsCLFCaD0j9fX3Me+zmN8hBd7VOQ86AGYOwmLGz35iWkHatQjuU6LydQBU
	+9bDxHz5YezGh/O34blUCxrU4RlVfrP2G2EZADlfi7xRWhliL4i61vzUly0F2rc6Im7Aap9K4qV
	iN0fiAgGmfYNtXvkiHueBcW3bjus8bz0J8cLBfPz73Law3qNo6KgXdG81cR6024lvQN/OHCfp0q
	aXkH9BzqDhy6rtBM7M5gmO+sZ6tFGPyE00oB7Cd5lZ0lhV1Nr395M1e6Lyh3ACXo5RzmTS3QH2d
	OEaToV1Z8Iro2BQRDu98xdqpqG8=
X-Received: by 2002:ac8:7f56:0:b0:517:6010:7c71 with SMTP id
 d75a77b69052e-519aa973f19mr9381451cf.4.1781708916916; Wed, 17 Jun 2026
 08:08:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
 <20260615-slab_alloc_flags-v3-14-ce1146d140fb@kernel.org> <78b67a9b-44e5-4649-957a-9d42bfaa098e@kernel.org>
 <26c29e4b-09b1-424a-b4e4-3358aac20115@kernel.org> <1bf749a4-1519-4d14-a0a7-6d8a56a6c850@kernel.org>
In-Reply-To: <1bf749a4-1519-4d14-a0a7-6d8a56a6c850@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jun 2026 08:08:25 -0700
X-Gm-Features: AVVi8CefVPn3P9FAIjVd3OjYJYXvkX-ZXLKpOt3BkEW1wHmD4yyLF5UmdjrpubY
Message-ID: <CAJuCfpFacu+j_sWPSxUyEbG_9=o=GycZ1Y8bVob+sGSGO2cDLw@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] mm/slab: remove __GFP_NO_OBJ_EXT usage from alloc_slab_obj_exts()
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17050-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F4B569AF89

On Wed, Jun 17, 2026 at 7:57=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 6/17/26 16:36, Vlastimil Babka (SUSE) wrote:
> >
> >> With some comments below.
> >>
> >> I was worried that perhaps replacing SLAB_ALLOC_NO_RECURSE with
> >> __GFP_NO_OBJ_EXT will create a cycle of
> >>
> >> alloc_slab_obj_exts(SLAB_ALLOC_DEFAULT)
> >> -> kmalloc_flags(SLAB_ALLOC_NO_RECURSE)
> >> -> alloc_from_pcs(SLAB_ALLOC_NO_RECURSE)
> >> -> refill_objects(SLAB_ALLOC_DEFAULT)
> >> -> new_slab(SLAB_ALLOC_DEFAULT)
> >> -> account_slab(SLAB_ALLOC_DEFAULT)
> >> -> alloc_slab_obj_exts(SLAB_ALLOC_DEFAULT)
> >>
> >> with __GFP_NO_OBJ_EXT, it would have been passed to refill_objects(),
> >> but SLAB_ALLOC_NO_RECURSE is not. However this cycle does not exist
> >> because alloc_slab_obj_exts() clears __GFP_ACCOUNT (as part of
> >> OBJCG_CLEAR_MASK) and memory profiling itself does not invoke
> >> alloc_slab_obj_exts() when allocating new slabs if SLAB_ACCOUNT is not
> >> set (which is interesting, by the way).
> >
> > Hm yeah I think we should propagate alloc_flags to refill_objects() etc=
, to
> > avoid later surprise. But can be done as a later cleanup.
>
> It's also not a new hazard I think because while previously gfp flags wit=
h
> __GFP_NO_OBJ_EXT would could be propagated more thoroughly than alloc_fla=
gs
> for obj_exts only __alloc_tagging_slab_alloc_hook() looks at them, and
> alloc_slab_obj_exts() (from account_slab()) didn't either, so the amount =
of
> (finite) recursion is the same I think.

True but I think we should clean that up anyway after this change.

With the fixup you showed, LGTM.
Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> >> Also alloc_slab_obj_exts() propagating SLAB_ALLOC_NEW_SLAB to
> >> kmalloc_flags() is little bit confusing because it does not have any
> >> effect due to SLAB_ALLOC_NO_RECURSE.
> >
> > OK let's address this one by this fixup:
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index fc5b8c85b690..dc4b4ae874ce 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2164,6 +2164,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct=
 kmem_cache *s,
> >  {
> >       const bool allow_spin =3D alloc_flags_allow_spinning(alloc_flags)=
;
> >       unsigned int objects =3D objs_per_slab(s, slab);
> > +     bool new_slab =3D alloc_flags & SLAB_ALLOC_NEW_SLAB;
> >       unsigned long new_exts;
> >       unsigned long old_exts;
> >       struct slabobj_ext *vec;
> > @@ -2173,6 +2174,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct=
 kmem_cache *s,
> >       /* Prevent recursive extension vector allocation */
> >       gfp |=3D __GFP_NO_OBJ_EXT;
> >       alloc_flags |=3D SLAB_ALLOC_NO_RECURSE;
> > +     alloc_flags &=3D ~SLAB_ALLOC_NEW_SLAB;
> >
> >       sz =3D obj_exts_alloc_size(s, slab, gfp);
> >
> > @@ -2203,7 +2205,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct=
 kmem_cache *s,
> >       old_exts =3D READ_ONCE(slab->obj_exts);
> >       handle_failed_objexts_alloc(old_exts, vec, objects);
> >
> > -     if (alloc_flags & SLAB_ALLOC_NEW_SLAB) {
> > +     if (new_slab) {
> >               /*
> >                * If the slab is brand new and nobody can yet access its
> >                * obj_exts, no synchronization is required and obj_exts =
can
> >
>

