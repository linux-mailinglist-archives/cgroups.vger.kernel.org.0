Return-Path: <cgroups+bounces-16443-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HzFAvm2GWpByggAu9opvQ
	(envelope-from <cgroups+bounces-16443-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 17:55:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A518B605217
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 17:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92CC330C92CB
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2506B3F8ED8;
	Fri, 29 May 2026 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLWHn8fo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D6368962
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068384; cv=none; b=o5Hu3t0Jx4U3ZZDgicrUD0qp1vL+G6m5Yf+nmies4kxFW73t9NrMtj1zhLXhj9fUN2VTEmPCBGE5parzl5qPTyIQSSiG0KKjTii4GMQaB8OyqPtmVMRVVwd473q9k4oPguGyJGAvp8S0IfrbmgriGQlxd3QTf3RDm0YCLXK+u84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068384; c=relaxed/simple;
	bh=fUAVSg4QOZYnfadLomH8mFKt48yRGhCh20ru3bdN+Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RekKRuiDJr2v/DOIlibtQkGG7hUG5c0WMHYjrMPjfkOeVjdYAmvC7ox2MKOmVTMRyv/+/AcvTmTrwnWfpTnTyqREUih5Szmr/cDgM5xHfXOZ0B6mu9ZsaisUYsrts10qIPzUOHTaf0meHVsXbzFKyX75QHdaLT2vv5+oDlxK5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLWHn8fo; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4856128f670so5354275b6e.0
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780068381; x=1780673181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXXCbhIHtRNsHen8pCYQ+YRxwoUgedEKjJY0J2w8T+s=;
        b=YLWHn8fo8uGidYq/Tb9nb00wlR0HlF5H5S/CACTxwNgE8Px4B0COQhsqME/hYCQgsd
         nkU9iikiVwCY64i5kp6a2ht5dlh82isWiZu8jrMrabqzSoPZzCN0MNUptavWbTTp+/Tk
         HpLhCzV0Uuu2JcffIFLWG2lJZzrkbYa4a6VV+elu2RqsrSwjNDPJ9+DytFFiHuy8DFaF
         dwhrnLc9oUERsd/BRS4C4rds9GKBTpYTVd/LYhVxsZWksh4ZpwJfo72wMHWL3K7YNaTO
         Vx8Ebjq07R58E27lYZXL2s0MM1nVMXj5h/DhTeOAgnxqCQMvFaa1oGEF3imJL5S3fi97
         uA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068381; x=1780673181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hXXCbhIHtRNsHen8pCYQ+YRxwoUgedEKjJY0J2w8T+s=;
        b=HSKt1/y9XIMWirs1D8IcypqklkKM3am34Wo7Tfs5EDYxAGITMsCZ5gYKcJEYkT1mpT
         cMODgR2Er2Gnfoo0+SpRQyz9C94FEX1GHdntD0sA7nUSIbi38EVF33bc2Otk9VUm572N
         DkXN1sX+hIIv+PeErajR4O75O1se6Ux+/yFfRAXVOcQorhUpdEjIs3Hn9osT8cRkEY3l
         2xgiTulyKtEJkBo4GRyxf7wGck8bCKznVjZ9tzE0f4jQ9mfzkeNmq8cEUH8w40VJjZus
         0MSJ1D5/GxnRH+ZYPAuL20gAumhp1HkfK1f/KhQni3CFf2usivv3B3Wn3dqQ+x469eXO
         Ifdg==
X-Forwarded-Encrypted: i=1; AFNElJ/5Y0f+Lqtmjr0kYdApssUTjU+Hw5fiLPhWFukqVWbVEOMNg50aiDUO60JVF0vKTgvDg/HWqrf1@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGzyna38GLIkIb6oAUOXCdTwp8LsQs5baMJ7pve76+GgPIyLt
	GaZqJ50VHXuUtpQjzRVlWdmV+TzU6DMHE/ksIqubdcxvOwnVYZTOQlxh
X-Gm-Gg: Acq92OHBLwxKxEBrVcpH5TcUMnXZAObufRoM6je7tJFyX5zhhA4BJr3xm2uSljh7rAx
	VTpLP/6/8Qc9fMSu7bKxMgdMBc/L3s3Gj86bOX70nTt3/6nmnFIuvSKIH+AZLvQD1M/UrfRhXuV
	vjhlmJo0FZ5gI2ZwOIRS4Mz6Z0RlmsUpP6aq/YJUjoT6CDnqqZsCiMl6JwJIDvMeyhZDY9Oo0J6
	dBFxo3qT04qrlnZDvoDFn5bpYAx1sODatOF2J3IGAaBX4rtLMzXWBtqW6H6kDvzltSiDTTVuiMl
	hWx7hkLbjr4lAAcO11bRw4l+ReZTelgPMv4ZVVlB6ic8F8MIQh0mTs2g47pN9cUS0ZdI+tgkCaH
	wIeJ/auOD/uBZCgb+qdekN0FNgmFcS+5kM7dNpmqauzyg4aklPTSupGaVpLpcZV8BrpXdWV5yyW
	FrMjaFf4/Hv43tgKy7NSDf974htqR2X46MYEHZAN2Qq709hiEFqpTy1oic7ivIEiE=
X-Received: by 2002:a05:6808:170b:b0:467:254:b90 with SMTP id 5614622812f47-485e698fcb0mr1813824b6e.10.1780068381169;
        Fri, 29 May 2026 08:26:21 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:b::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485edc5fa67sm792027b6e.6.2026.05.29.08.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:26:19 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <ynorov@nvidia.com>,
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
Date: Fri, 29 May 2026 08:26:15 -0700
Message-ID: <20260529152616.2308736-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528124133.c88c27b11a8ea0ef05e494f7@linux-foundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16443-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: A518B605217
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 12:41:33 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 28 May 2026 15:03:37 -0400 Yury Norov <ynorov@nvidia.com> wrote:
> 
> > Reassigning nodes relative an empty user-provided nodemask is useless,
> > and triggers divide-by-zero in the function.
> > 
> > Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> > Link: https://lore.kernel.org/all/CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com/
> 
> Thanks both.
> 
> It looks like this is very old code, so we'll be wanting a cc:stable in
> this.
> 
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -370,8 +370,13 @@ static inline int mpol_store_user_nodemask(const struct mempolicy *pol)
> >  static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
> >  				   const nodemask_t *rel)
> >  {
> > +	unsigned int w = nodes_weight(*rel);
> >  	nodemask_t tmp;
> > -	nodes_fold(tmp, *orig, nodes_weight(*rel));
> > +
> > +	if (w == 0)
> > +		return -EINVAL;
> > +
> > +	nodes_fold(tmp, *orig, w);
> >  	nodes_onto(*ret, tmp, *rel);
> >  }
> 
> I suspect we should address this at the mpol level - it should never
> have got that far.  Hopefully the mempolicy maintainers can have a
> think.

Hello Andrew, hello Yury,

I agree with Andrew here.
mpol_relative_nodemask is called from two places, the first being
mpol_rebind_nodemask which is the calling function seen in the bug report as
well.

The other place is mpol_set_nodemask, which has a helpful comment that notes:
"mpol_set_nodemask is called after mpol_new() [...snip...] mpol_new() has
already validated the nodes parameter with respect to the policy mode and
flags".

So it seems like we are missing the big if-else if-else if block from mpol_new
in other places that should in fact have it, like mpol_rebind_nodemask.

The approach proposed here of just checking whether the node weight is 0
won't work for a few cases, namely for MPOL_DEFAULT and MPOL_PREFERRED where
empty nodemasks are actually allowed. So what should really be done here is to
do the full policy-nodemask checking section in mpol_new and call that from
mpol_set_nodemask as well.

Thank you for taking a shot at fixing the bug report, please let me know what
you think! Have a great day : -)
Joshua

