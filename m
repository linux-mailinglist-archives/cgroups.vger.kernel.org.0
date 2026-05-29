Return-Path: <cgroups+bounces-16456-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KhRMJ7hGWpmzggAu9opvQ
	(envelope-from <cgroups+bounces-16456-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:57:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3920A60793C
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 334253191124
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 18:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81826426EB2;
	Fri, 29 May 2026 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI93/5Q2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86742DAFCC
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080066; cv=none; b=TmSDwSNjFSUCXBMC2smvAqfjvxuoQPh8BeWgvFhIcyFeIPvUDEm+I5a9X70wBbde4UA3/LqZxeaxmnHxg4XpAewwP2Vq/IykPy1JQRs5RxYHd5gJZkPYo4KyZLCRgEYEd2xNoSuJQjq48O9wvikAPQqea81eE5pYe1uSLSapcS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080066; c=relaxed/simple;
	bh=SM6Rr5uaVZW1+XCxt/LrATHSjmNJ6DtiQanbRKkyf1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQRp2eOB/dJaCaP+eXdZHugvJi3F2mYif3U4tpbSk4yExzRVWLyFPUQbFaz+lNgppfFazRDuyJCAKhiGuVquOYhtPS7qa3lOk2Ufw7kTRRSe5u676gHQ5vtMpO5GdWbGeJciC9GS8Fz9fhE44sndMukve620J6zYAr/BYJS1Co8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI93/5Q2; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69d6e5c4bcfso4724455eaf.0
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780080064; x=1780684864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG2Yp6iNC/83YtFKga+pv9BmUEKJyvbZYWLhtH4z0Rg=;
        b=mI93/5Q2OrEYMN0gosataUkrKgIkB6LbQZy3p6RjrwMYCPJOFmUMP1kyq+DDXdZkxH
         SMmUgNAk60Ja4A6ZAPIerVwvZcViZiOO3YdvpxuyO4CMc8q+1Lde80xfUH16mapUld2J
         jfV5orUt4YP2SEwcm+qcUweDMwRWP2wdGi7/dc8Ks1fu8pahH0yND27x9TRmBIfd0abU
         sDixfS4Ys7Od2mSkb+tKvjbN3dqJBazXpjUnkDo0HjVwmJxXC53G66rar4LkjauebNAT
         V39w4mFAi73RWDbXEFq9l8H29RNCZ+yFL9AIBtHb06oj+1pyiFJHFEg6Pn+EHBRVWsWL
         1GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780080064; x=1780684864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VG2Yp6iNC/83YtFKga+pv9BmUEKJyvbZYWLhtH4z0Rg=;
        b=SUm0f/WdTEqUH5X0zhgwygfLoKVyDvvD6uHecviS33vKI9gMQAMsUnIBwzSoEhMvN2
         /v4KtSpX0LQw5tXEl5wv1fbMjA5wKrTmXnmmd4DPOAbsX6RS/FJDteiHWmMuUR+x4Ee0
         0/ABoGkG5CLHk+jwKjaYEzPCuhR9KuosGY5Xnw980xEt0w4ExtpF6b2wszJdWGkdrCJP
         KyZq98w121gwgp85ZjOwhV88f9PWZzwembR1zZUqEeDsZRCpW20MQ4JdV+xBXOW3Hdzi
         ux3mnO/3z0gM895NQhjYDRtto+mAb4faN7rCr15burgNoeKiUwiAY5Rdn/YtSOYz5e2W
         HuCg==
X-Forwarded-Encrypted: i=1; AFNElJ+5TM4GzEEBTyM2QYXJ0SfZbpu/Tx4VvICJdm8vOizFP684qc2fWI8+KrSvIGC5jipCwI73Xspa@vger.kernel.org
X-Gm-Message-State: AOJu0YwTuPyY1NKXUhKamL+t+CdR29wWa5JwJM3x+X5qURlWqGftOmRo
	6jopIFvU+9BGTQFFMRStKeDO4Rn0s/IqBwo6WJGe/XNH9nTyyk0LZ4o6
X-Gm-Gg: Acq92OHEwGMBmtu0k0ut4ejj9azVQRKxpU4bOeJbR1/e0dtCSKbHXJsopSu/prdJE2Q
	uO1IPXKoRAwaCJWr5djyywKeu8jEWW2ntYcCzryhvpcc0qJV9z5Iokl7kUdq8bBfFDOnePQdBDH
	/EE8bIgVOKliKM/JtxX3xPsm9UD2p25va5xVCGQq1zq7xRmXBwsRRbUQYLRQLlAI14zEmgiLrq7
	zbKHjGH9j0c3q1OTde0tU3GBz6kOMZj6rnglGwoL7DOqGFKRptDuYWK6MJ1aiR1kRt++MkmTtrq
	BHyGMAsTpUHTY54B3x2qKicKJjPg8g9oXufv/YZXYOkQao82wiIb1a5LuInC58Kb48OV0K22VFX
	j8MtL7retrLuXSN0p7NZPpzxOkt6hFBB75Ya4hQLxJGmmTnsII8ADNwsoHZ5aSi18jHE3wLU+Dj
	u+u2MKWPbtRUZFSRH/v2ElccCdbnZloYgl2DwSGSqN9d/pLhANhrT0nYMisIyQyqU=
X-Received: by 2002:a05:6820:2082:b0:69d:9e3d:4e19 with SMTP id 006d021491bc7-69e1038541emr288425eaf.30.1780080063615;
        Fri, 29 May 2026 11:41:03 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c93a22989sm1468687fac.1.2026.05.29.11.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:41:03 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Waiman Long <longman@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: don't allow empty relative nodemask in mpol_relative_nodemask()
Date: Fri, 29 May 2026 11:40:59 -0700
Message-ID: <20260529184101.294638-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <ahnRIDBk4bQ3xX2q@yury>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16456-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 3920A60793C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 13:47:12 -0400 Yury Norov <ynorov@nvidia.com> wrote:

> On Fri, May 29, 2026 at 08:26:15AM -0700, Joshua Hahn wrote:
> > On Thu, 28 May 2026 12:41:33 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > On Thu, 28 May 2026 15:03:37 -0400 Yury Norov <ynorov@nvidia.com> wrote:
> > > 
> > > > Reassigning nodes relative an empty user-provided nodemask is useless,
> > > > and triggers divide-by-zero in the function.
> > > > 
> > > > Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> > > > Link: https://lore.kernel.org/all/CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com/
> > > 
> > > Thanks both.
> > > 
> > > It looks like this is very old code, so we'll be wanting a cc:stable in
> > > this.
> > > 
> > > > --- a/mm/mempolicy.c
> > > > +++ b/mm/mempolicy.c
> > > > @@ -370,8 +370,13 @@ static inline int mpol_store_user_nodemask(const struct mempolicy *pol)
> > > >  static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
> > > >  				   const nodemask_t *rel)
> > > >  {
> > > > +	unsigned int w = nodes_weight(*rel);
> > > >  	nodemask_t tmp;
> > > > -	nodes_fold(tmp, *orig, nodes_weight(*rel));
> > > > +
> > > > +	if (w == 0)
> > > > +		return -EINVAL;
> > > > +
> > > > +	nodes_fold(tmp, *orig, w);
> > > >  	nodes_onto(*ret, tmp, *rel);
> > > >  }
> > > 
> > > I suspect we should address this at the mpol level - it should never
> > > have got that far.  Hopefully the mempolicy maintainers can have a
> > > think.
> > 
> > Hello Andrew, hello Yury,
> > 
> > I agree with Andrew here.
> > mpol_relative_nodemask is called from two places, the first being
> > mpol_rebind_nodemask which is the calling function seen in the bug report as
> > well.
> > 
> > The other place is mpol_set_nodemask, which has a helpful comment that notes:
> > "mpol_set_nodemask is called after mpol_new() [...snip...] mpol_new() has
> > already validated the nodes parameter with respect to the policy mode and
> > flags".
> > 
> > So it seems like we are missing the big if-else if-else if block from mpol_new
> > in other places that should in fact have it, like mpol_rebind_nodemask.
> > 
> > The approach proposed here of just checking whether the node weight is 0
> > won't work for a few cases, namely for MPOL_DEFAULT and MPOL_PREFERRED where
> > empty nodemasks are actually allowed. So what should really be done here is to
> > do the full policy-nodemask checking section in mpol_new and call that from
> > mpol_set_nodemask as well.
> > 
> > Thank you for taking a shot at fixing the bug report, please let me know what
> > you think! Have a great day : -)
> 
> Hi Joshua.
> 
> Indeed, quick and dirty shot.
> 
> The problem is that nodes_fold() can't work with the sz == 0. In
> other words, folding to a 0-bit bitmap is an error. We don't check
> that on bitmaps level because it's an internal helper, and it's a
> caller's responsibility to validate the parameters.
> 
> nodes_onto(), or more specifically bitmap_onto(), is a different
> story. In case of empty relmap, the function actually clears all the
> bits in dst and returns.

I see, thank you for helping me understand. Yeah, we probably don't want
an empty nodemask here regardless of policy, as long as MPOL_F_RELATIVE_NODES
is set.

> I see 2 options to move this forward.
> 
> 1. Simply disallow empty relmap in mpol_relative_nodemask(). There's
> no valid cases for it, AFAIK, so the nodes_fold() limitation looks
> reasonable. We can consider it as a new policy.
> 
> We've got 2 users for mpol_relative_nodemask(). In mpol_set_nodemask()
> we can simply propagate the error; and in mpol_rebind_nodemask() we
> can throw a warning and do nothing.

I think we should never be able to reach mpol_set_nodemask with an empty
nodemask if MPOL_F_RELATIVE_NODES is set. Not sure if we need to be extra
defensive here.

For mpol_rebind_nodemask I think we should actually do some more checks,
I think we should do it in mpol_rebind_policy since it gives us an opportunity
to catch other sources of failure too, like calling mpol_rebind_preferred 
with an empty nodemask as well (which shouldn't be allowed for MPOL_F_{
RELATIVE, STATIC}_NODES) as far as I can tell from the checks in mpol_new.

Setting empty nodemask for mpol_rebind_preferred won't throw a div0 error
like for mpol_rebind_nodemask but we can at least throw a warning like you
suggested. 

Does that make sense? This is your fix and if you would prefer to address only
the div0 case, that makes sense too, since the empty nodemask for preferred
is more of a semantic incorrectness and will not cause panics.
Entirely up to you! : -)

> 2. Follow the spirit of the nodes_onto(), and in case of empty
> relmask, clean the ret mask and bail out
> 
> I'm in a favor for the 1st option, because empty relmask looks buggy
> anyways.
> 
> > The approach proposed here of just checking whether the node weight is 0
> > won't work for a few cases, namely for MPOL_DEFAULT and MPOL_PREFERRED where
> > empty nodemasks are actually allowed.
> 
> Not sure I understand this. The mpol_relative_nodemask() is called
> only if MPOL_F_RELATIVE_NODES is set. In mpol_rebind_nodemask(), if
> both MPOL_F_STATIC_NODES and MPOL_F_RELATIVE_NODES are set, the former
> wins. How would the RELATIVE mode mess with the others?

Yes, you're right, the case that MPOL_DEFAULT and MPOL_PREFERRED allows empty
nodemasks is precisely when !STATIC && !RELATIVE :p this is my bad for missing
that case completely.

> Anyways, I'm not really deep in mempolicy domain, so please educate me if
> I miss something.

Thank you, I have also learned a lot looking into this to think about what the
best solution is!
Joshua

