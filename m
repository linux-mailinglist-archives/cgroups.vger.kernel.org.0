Return-Path: <cgroups+bounces-16926-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KqvkI3JhL2qv/QQAu9opvQ
	(envelope-from <cgroups+bounces-16926-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:20:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFA7682D6C
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:20:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ctapnqhS;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16926-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16926-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7333F300734D
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 02:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819BE21FF25;
	Mon, 15 Jun 2026 02:20:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA9D155757
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 02:20:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490025; cv=pass; b=av/G/Zh5AFCtGPjG1pMy32AIFMIURwWAm0F7KviXMy0BSniblay5Cxt4EnvuLJW7ZkPbDUgZ/WmlnEwtHLBuE4W7p5Tgkl15WMGz0BBaUyMmFzmgUSuAqvuOS+a0Srbz325Fciv/T0BeyF4FY9+761tSZMVbWLqDZpLtKIQjTq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490025; c=relaxed/simple;
	bh=Xgw4qL6lxzNspQ+9vtQJ2vaV86VdpfEsnqnAlklgXA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Md2XKCMv5RZyvlKrMpcYHJhs8w85LrhQ6ABvoE4sORgruB0c5mJdKzbwOKoHJnKa6IAXgt3Q695jxEucW//cOyEWpZI9j6CLTPjf/FoSXoDLgIalyzhUVcpY+hLR6ModHkijE57+FZBfj96LKNOMozFBGmUVccZOTZ7/gnaEq10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctapnqhS; arc=pass smtp.client-ip=209.85.160.181
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51765531803so813451cf.0
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 19:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781490022; cv=none;
        d=google.com; s=arc-20240605;
        b=O8UDHs5CAqLrnlNFqCb9OTlyo9OhKTZt0B6v/z9VAxDhd64pad+2Iyn/7WxlS/WgyL
         rz2COAYTlj214tbwS1wW8SZf5+PiLMTzqew3+O1eVULz1nkj7K/q1JJwOhEeEDBaGVu0
         uFw8AMrEEiHJZDB3spLPjdsb0UM9PTXgdCYJJyBcEyzX6a+HDGU5+rEz62Jy1b6BrNsq
         iFDjidUwCc1FuPmD99E4RkmTE9CoUquoeMPqjsETmgFJRV75UQlH8r987xGvWDCA89tk
         Ao/lB28l+wROZ4vhH0HNcmahzN/4/p4LRWwlbK1y8r5IcxaSC5VzPY5NWKFlGMkIKok9
         ZahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xgw4qL6lxzNspQ+9vtQJ2vaV86VdpfEsnqnAlklgXA8=;
        fh=1pa9RWCgwYrDL9+j4SnIQasAmwI+MsJI/GdIbwoO94I=;
        b=i08a/X9IOxkgrJ3QJjZZfv8srlQvjAb5NOmvLSs8EHabxF7llOecBPRx8+329oF7od
         PnMPrv/4FibpkhOaeGjpJTrkHioBCj9kegAmS6cXaYZa2LpFlecqNQ9NSrCLeVJCpMy3
         rz7b5S0NDqoOWs4SolXNxe+6jZkXeuSC8o7jjjaQil9l3aItNTEh1xQr7ooqKf9ebs/r
         Mj9wvnkBdgepIY+rVUaG6Ra5U7IdSde4CSU5HpHjSlRYV5d3NoctoyzV6QqF9R6/hmy2
         F+EVvfsaLyw3w2MHCCol20iTtwM5D9NXXdlYic0GK1+BFzFsyQcpeHyFC7dcv4CGpQer
         0cdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781490022; x=1782094822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xgw4qL6lxzNspQ+9vtQJ2vaV86VdpfEsnqnAlklgXA8=;
        b=ctapnqhS1GVU3JeaEk86REcnlG12brIj/vumSWsooS3GvrmZ8Yp+IcGKDqmqGR8UrD
         ccEF5bhjf/9S30WkuzEua655uoV3TPOqukbrHAyTqh88m6HfxmW76yTY1NGNxlgOR9HD
         eTQmonX7AM4TQdn75lpjXLlPXs1C2rIRbT2Aqq24o5teqqZiyDiHhq0/4v4d1doVptbX
         WZriSLW/pbNps/uYvg+r4A7Vn2IgyVBd6JnnLV20KnZuMaHXfgnEp3PTNjgnxEui/5Zu
         ZIvZjyM66E+rfKLQnq320q3959p8A2pzrhK8woSIZgoaM9i50KrpijqOuXee5A7rLrj9
         k1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781490022; x=1782094822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xgw4qL6lxzNspQ+9vtQJ2vaV86VdpfEsnqnAlklgXA8=;
        b=mnQ+sx3MD185G8s/RHXmLeE3NUp/VroSQ00u1elhsTNR8z9mZn2mpOBLReVl6JuOYP
         63G24VHpUJ44c2J46QPYQVWCPnQHmGtAgH37xuhM15Bd/TyyYaGTLOrMMMxJ/2qFrmhC
         NgcMnWyunRH22N75zLUU8JvVXC+TUZH3n8arvH/s3OdKa1Thp04EXSuivnbtBmFkBYDr
         TDUBTYaTWWx5iBw9LBWtbD1pxjJlBu5Q4oKd0Mruy9mAM2DOJAhmu8H8DGCotzVWGXZ4
         KQTZBYRgXdXaW91NjZGH9g4X0Nxyd+6ppRkgfjdeoRiktoqE09HPWYHaeH84Xvh6X0zl
         0Zcg==
X-Forwarded-Encrypted: i=1; AFNElJ85xj5lkcz4B91g3nbBZxEbZ3XuF7EnB0R5fPD/uIHXriJp1n90gP0dI/+GesBnaJlN1kyvq+7x@vger.kernel.org
X-Gm-Message-State: AOJu0YxwH27nPExCCkMgBf6AZHDfrvfu+7edmN2bgLnK2L3ThDoHQLFX
	w8yzpUkyzpVmkh9lwtbr2+WPH/JPR2wbBWpJLeM1YWlqmaQmImcAL9By/ewsWiy2O7OSMgHtNIn
	Jy0G3j9C2qV94t9gxctv74BSclH2OMPa4SdC54B9b
X-Gm-Gg: Acq92OEAdlyesj7SgCM8IBeEqCQ51WNLnCXrNaErcb6yxi2IX11RVgAK4dacMccKLHZ
	rSDFyTTSysKgMRdZKUREQgY+lExJ/4tVl0HVMSCPA1EtqvbVeyYxWUJqycaRzIiuhqNJOtgQ0XA
	TgENwoDL6K3TwIMubxYnBFydy855Acrcu+VOMH4Oe4Iv448fr7tRqRpKMLnsNDOShAhq6WoT7+f
	ZTb+90fVQ3QB2ENfTIkNGIyrxgqGF38Bb/rFjp1hRqxIsy2iBqV0q1fUNBM6Dv3cfIhljVHRGY6
	YxSw3Q==
X-Received: by 2002:a05:622a:2448:b0:517:99ea:ab79 with SMTP id
 d75a77b69052e-51955ee0c18mr14089111cf.25.1781490021868; Sun, 14 Jun 2026
 19:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-6-7190909db118@kernel.org> <aiuB47Lj0vFGyuFA@fedora>
In-Reply-To: <aiuB47Lj0vFGyuFA@fedora>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 19:20:09 -0700
X-Gm-Features: AVVi8Ce9rsblLKml24B6QvenRpvfycL6dO5Bte5pwQ9MMVQHmEMX9EC9SyIiJOY
Message-ID: <CAJuCfpFBM8wHPH8f1ekzoTVaxuSLkent64f+2xbb=3DGkp6fAQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] mm/slab: add alloc_flags to slab_alloc_context
To: Hao Li <hao.li@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hao.li@linux.dev,m:vbabka@kernel.org,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-16926-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AFA7682D6C

On Thu, Jun 11, 2026 at 8:51=E2=80=AFPM Hao Li <hao.li@linux.dev> wrote:
>
> On Wed, Jun 10, 2026 at 05:40:08PM +0200, Vlastimil Babka (SUSE) wrote:
> > Add alloc_flags as a new field to the slab_alloc_context helper struct,
> > so we can pass it to more functions in the slab implementation without
> > adding another function parameter.
> >
> > Start checking them via alloc_flags_allow_spinning() in
> > alloc_single_from_new_slab() (where we can drop the allow_spin
> > parameter) and ___slab_alloc(). This further reduces false-positive
> > spinning-not-allowed from allocations that are not kmalloc_nolock() but
> > lack __GFP_RECLAIM flags.

___slab_alloc() is now using alloc_flags_allow_spinning(alloc_flags)
while function it uses (get_from_partial()->get_from_any_partial()) is
still using gfpflags_allow_spinning(gfpflags). I'm guessing
get_from_any_partial() will be converted later on but I wonder if that
conversion would better be done in the same patch to avoid
inconsistent behavior during possible bisection.

> >
> > _kmalloc_nolock_noprof() initializes ac.alloc_flags using its flags tha=
t
> > are SLAB_ALLOC_TRYLOCK. slab_alloc_node() and __kmem_cache_alloc_bulk()
> > are not reachable from kmalloc_nolock() and all their callers expect
> > spinning to be allowed, so they can use SLAB_ALLOC_DEFAULT. This is
> > temporary as the scope of slab_alloc_context will further move to the
> > callers, making the alloc_flags usage more obvious.
> >
> > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > ---
>
> Reviewed-by: Hao Li <hao.li@linux.dev>
>
> --
> Thanks,
> Hao

