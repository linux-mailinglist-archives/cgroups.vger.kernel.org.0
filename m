Return-Path: <cgroups+bounces-16930-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9F6DNit7L2pXBQUAu9opvQ
	(envelope-from <cgroups+bounces-16930-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 06:10:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B76368336C
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 06:10:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=VcrzFiPu;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16930-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16930-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD5630071CF
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8142E737A;
	Mon, 15 Jun 2026 04:10:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8352AD2C
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 04:10:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781496617; cv=pass; b=P1wwu7NeaMBqLzwnjvngMwFiyfZvfZ5hrGv4PUUWZCgjXbiozDOV3k8Q87riflaTiRfdgRFn3TGIBXxnE6uWavdFfm+miBR9y27SJWjIb59kmQA31u2PcmLTA5gJGRe2nSv7WP4+TtBMe+EM/GhdkSDVgZGhofNmItLmEhHpkGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781496617; c=relaxed/simple;
	bh=+j+8ECS0Q3OHwNd/BH9xd3i6FPy+P8/UzosXsmEen0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQhmQ1JIA7cEdP/qfwDsVjtJCrNdhEk4l4iavYjhjX3EZKrhDj0A4QxlaZElVF5/y00gkKDmRnwyfzlDhwjJHtZXOv6OD0iKYCXHGsDiQJOsvAkOCq+kJ75ZFWo6USgphyqMK8iHa8Fg8fDJE+SAn+5yaxB/YOO+MwG94aCWu6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VcrzFiPu; arc=pass smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5175d339e8bso812261cf.0
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 21:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781496615; cv=none;
        d=google.com; s=arc-20240605;
        b=jOvKNzkYhVPKfOIWVEwqbuqI6Dc3CLxZjBX+Qi+X64jogZ+ZzvzdNqxn4pp4QuiXPx
         ZPuGBTpgd5uV5BmyzsslnHlcgwW2p18qalFooFE06PpeMN/GMh/f0fGDCiHG8LSPSPh7
         juqg4yFS/erAQG3gp8wVE6o/AEYkyfvhUCBX8QaN74Zen+x7UbQ7myagMcqtWxIlEivV
         IsA04DA7zlfP61iF52pG1YoEheNRTdbG7kPHe8EmR/XrIn3i8NVTHv6/AjpsqBC9eDVh
         hSbxNGVA8v+2vbBLPC7/PUxxWRV6iNX8oN3vAdlXD8N2tnWJlBRatLXY1307zJz2WUdW
         HNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iLKGUqhqQ1vZwTsHa4HAqlBUYr7V5S3XZKe4bVT8MW4=;
        fh=uGwwHKYC7Q+3Uilodpkg19qLJ/BkRK5Kb/GSzSzXQ1I=;
        b=LD9y3SvOujU+TvQ8MV4/7jA80erw3szselpBNcXor0Sj3Vf9cz5o419szyTn2b0lAK
         WdCTiaJ4AU3fnuAMTYd2G0F1qxmzNa2AhUe2InGckLvdSbgGW5I04MI0cjEm5gCe62PD
         WwN5OMBbJoxE18fiuc0lVnzBjwAmOrKAGVcEXm0DFsE3QmtFmHMC5zidl059UOkuc1oA
         uowuwhv4pmN0FnD0xFAFJ0piq8+ztwBmyeQ5clfqliztU7JKuZWQZJP2rGhcD/8rdgo+
         AlX/aV5v+LxPOByHgQXDMRMdpMLK/kUWMoOEGstVDMhvhg77mG8XilM/2WTgYA/RIhgs
         uePw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781496615; x=1782101415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLKGUqhqQ1vZwTsHa4HAqlBUYr7V5S3XZKe4bVT8MW4=;
        b=VcrzFiPulaEjsx755Zt1PdqNYMYEvgKUOG43x2/vHcHOkntvDLSrCrl2VqgStiG0lT
         kRO8wNbcTaAMLtFSF4L5R1uXxxD4biMgVfs7W9EUSGZp9Z8x5TWDZycOOwzfoWEtc0wI
         QwjP9lQ0bGUGEGak3Xnp4iwJ+RncaF1Wxg5I1pfrrFv5QaCAteG+ps/qFChHCh0IEiHo
         q9VOhQiRwV0/aVcYMslobIIJnC+7lzp9Ga3WLfzCceve09yslaBuRySQGngDMTeFikkU
         BtTXvYaydMncrLNaFXVNkej2PZDDlWmwkajBn2ucDfCp1XAPO9tUVe9CgMtu0zbBgGUz
         +T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781496615; x=1782101415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLKGUqhqQ1vZwTsHa4HAqlBUYr7V5S3XZKe4bVT8MW4=;
        b=RN4JrZcxPtLvglcLe/UMyrFCggj8S3UVU6+7lTkIM6xUZ1cl8xWKQ5oItNX4gUOrLA
         LEOukXZIyq4x9ZIgvsmn9pHRF1AQAW3UdHXYEBNXddXaKtHj+uzGCbCDbIMkxwNmch4+
         s7K64J+RJ7qyE9M8uJoR/LNQdr7QByBBBSpY7jk+jaMqj114cymXef/ha4/qupFFnOcG
         cP3h6WKJVITacQYUVfOM9wdL9ctYWM1lB2tMA9lBCNOny94NhvtFrDIWhBnDhWILjtYW
         5bwYX1ng7fGXVls/JspUqYHvVRUSsJ59AD1oxJ59LP9N452us6m4tXVOCL2J6nrmcPj+
         4UPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NrUipojTO9XYAkQ54etRkBRlmm8z3LWQPl7wFdtmOMvpMRcuaPcYl87qE6JEm7Xx6BPkOy9bW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyrgq+s55jHbAVk6J6FL3Bs1J43px8+yGhBFT6WoDl7FcA1TJE
	KAGy3W82ukI93kTxOmubGWpXaKk9iX2QNmkwZFCoeLVGkdQM5HVq142Oo+d9FRTohXfK7rzP6iL
	hRX56OyUzcVYQ3bhmGn9N/Ee2/gV79wkJzbbYeatT
X-Gm-Gg: Acq92OG30mZbcAU0bUUZo+p74vxWJWWB63w7PYYGf0/ONRm8+ZevYByOh7yYQm9ASdy
	waXRNd9w3UIo6bBNt4ZgOnb9HHcHrRs4/zzpXkfcdAjy0wvwIw+/zdndkiXWSLSs6DqDW6Azdxj
	ku+81DfYYAti04Yq5CAZGGlfno3agZzcIP2dywW5d7i+/wQsEQQAE3blSG0WNO/Fm1HKPbXnOsY
	pcwVIOCjRujAi16qRzW9fhl5O4u6TkKuehMLYMrjQkakqu1s+iam9GWAgsVq6JhJS829Tc1z8VW
	+lzDQA==
X-Received: by 2002:a05:622a:1f87:b0:510:fa1:73c5 with SMTP id
 d75a77b69052e-51954a9c4f9mr13307001cf.16.1781496614188; Sun, 14 Jun 2026
 21:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-8-7190909db118@kernel.org> <aiuX6SRATJoaq-jH@fedora>
 <0546df1f-616c-44b5-8a1c-f96d5f33d8e6@kernel.org>
In-Reply-To: <0546df1f-616c-44b5-8a1c-f96d5f33d8e6@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 21:10:03 -0700
X-Gm-Features: AVVi8CcO41aAq5lFBicCgK1drW-0d_MEvn4CW4JK61tK1r4R4tO2C0QXI1U6dPo
Message-ID: <CAJuCfpFSv64mOvJ8PsOaX-ifdRH=HXPYtOE1iy=SPNRiGKKMSA@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] mm/slab: pass alloc_flags to new slab allocation
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Hao Li <hao.li@linux.dev>, Harry Yoo <harry@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:hao.li@linux.dev,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-16930-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B76368336C

On Fri, Jun 12, 2026 at 2:59=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 6/12/26 07:26, Hao Li wrote:
> > On Wed, Jun 10, 2026 at 05:40:10PM +0200, Vlastimil Babka (SUSE) wrote:
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -3378,9 +3378,10 @@ static __always_inline void unaccount_slab(stru=
ct slab *slab, int order,
> >>  }
> >>
> >>  /* Allocate and initialize a slab without building its freelist. */
> >> -static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, =
int node)
> >> +static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags,
> >> +                              unsigned int alloc_flags, int node)
> >>  {
> >> -    bool allow_spin =3D gfpflags_allow_spinning(flags);
> >> +    bool allow_spin =3D alloc_flags_allow_spinning(alloc_flags);
> >
> > nit: allow_spin doesn't depend on `flags` now, so it seems we can delet=
e the
> > comments:
> >
> > /*
> >  * __GFP_RECLAIM could be cleared on the first allocation attempt,
> >  * so pass allow_spin flag directly.
> >  */
>
> Right, deleted.
>
> > Otherwise, looks good to me.
> > Reviewed-by: Hao Li <hao.li@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> Thanks!
>

