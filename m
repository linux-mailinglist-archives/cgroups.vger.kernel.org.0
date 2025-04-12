Return-Path: <cgroups+bounces-7497-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D8EA86D20
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 15:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CAA440BAC
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 13:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3094F1E5B82;
	Sat, 12 Apr 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S47UC5Ur"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F56190057;
	Sat, 12 Apr 2025 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744463357; cv=none; b=caYF5W/br/xF1tBboVbtIgjaEGt8enM6l40CgChUm+0ltmCrx/ZrCS5hrhGbH7xCcjkTjpQ/rGhN6wkC1H3c3VEoNFx54pCKG7QrjsZx53pLQMk8FL/uC1bfnBJKiK8+3+eI8Xi5n0TlRtNwssUFjE3L7DQo0n/Npv038Bdq1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744463357; c=relaxed/simple;
	bh=b44HDDmAcQ+0IK3uLPD0Phdq7KVtbF1DvQjpZuCuDx8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=oMaF+bnUwDDE8/uJPIulNAcMfosEcb88bFYiZSpIJwbu6z+XbZLoX3atZXkHS2jJurUJwteqwwAiFGlZbS0ppTD37o7mwpd0eucEFkKfLBV2KNOAqqiUIctadgVBUVhdyrATDJsa/umVoIMmXJbOrxrWpGf6ghXD2QuEYax5jMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S47UC5Ur; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736b350a22cso2473693b3a.1;
        Sat, 12 Apr 2025 06:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744463355; x=1745068155; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LeE90RsIqmek8a5r9ooo/JwJr81IVEM/R4FGmrxaySU=;
        b=S47UC5UrTsnos0t2e8u8IcOajBKExlr9jk4TZ/Lun+C04Y1jGnCtWbUwM6E22XiwCz
         /CEVIYS49sKed7xW1ojEngKCSwzkDWByeuJqm/1jQjlbsdPT14ZEFCWRBGYTm4KSkP0F
         dM+4Ah8O9Zz0QpO4uxKpSlXyReUREMb4XBIS9MdrJSLgecE5Pf8yVNX4CDypgEONQ2vD
         A2/It06EyoVmXKo3N1EtU8fus9aqBbVt+KdHxDjIqLsTpR4Z2UDpCHzJJchxGYtHwJyC
         bT4cankdiSsjTU8p0MZBalr7UNtt9SVyAthBzpks4UQ4lnaXAKud/e9bzeRflNRaTVcv
         UIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744463355; x=1745068155;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeE90RsIqmek8a5r9ooo/JwJr81IVEM/R4FGmrxaySU=;
        b=jKbpI7qcqL1V6wY4uyRqiqrbThSy1sG81Qcm3i7BtHNqsE2WEVRvhNHpexK1dwo7SF
         dWgE2g4qhHw1qNYWHlTrODCLV8Vy6Ytx8cdk3Btvtjma61YwAmzg6W+37EWkIAoY2JQ2
         XFqkAaXNu0eWbG/WEh8NHMninVOgquv/llx1yXcirZwCdEyQfXkZtI1TUgLVs+iqDIVP
         4kB3HDWn07qCezoTRaUYkcr5x6SI9Ae+JPqO20iPPLhsM5MHJa2B+5D2wIebw/q2TE3F
         VBzmxsDQaXA1P4YjrLONtj8edwlnsdqfq8nFc6MQRQ1xoTcXFsNK9oK7dvUADQAQ41j9
         pBgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQSPCfHZZBkpH0cOjiE0YnlSkflm6cpGqRxQJ8hNGONxYfCkPtB959l0AHR9r+xbs4BvU/MVw/@vger.kernel.org, AJvYcCWpr6DfUVbhW5la0Ep6EDs/mZYMoqMasVC9zce2FGrBOgttdBmV12RitGFIyRD7jf2gg/QS1mhKzqHEqH8e@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQq7tE/qz/q3tQ9iQ40J3SDTc572VM/dALwJECjSopnbufw7b
	0IWsnGB5L2wj125biHtRqIMG+R2hftiziZA/BZV7d7jaCqwWRpho
X-Gm-Gg: ASbGncv/PINDIx+AqsgpQ7IrRXhQ4iocxDZFCPHVYCbYG1qf7ldU4mnx2aCvW07NHTF
	OfOLzYgNEKFTvc80aVWMJp9mYIX6m46IhGYGHP/aB8npPDu8Im5Q6LcbVMDqLjfgvntbhbJagFg
	U0JmiJnepOiwL+tXGXNZ9C2+9T2Pel4VG4n2QoqFKIjDRxdur16rEq70GzvVrxfC3KM7SBxazfa
	M7uJEg5G15qKC7xqCXGz/njeRuIXlxDH8CbFjyIbA2ICEGdhPMrx5SRacRvf9R/rY6Emsk8WAt3
	4sp69UfXJSOQsyQco9uihh8e8AyIoXpWGA==
X-Google-Smtp-Source: AGHT+IHBsDfcdsOcd7CplkH7Dbko5DJ3EkuJ4/wwFpSfM2dGkBYge17HnJ1c3n3cLTh4KEO6EZWJ8Q==
X-Received: by 2002:a05:6a00:240d:b0:736:ab1d:83c4 with SMTP id d2e1a72fcca58-73bd0ea5de9mr7961287b3a.0.1744463354484;
        Sat, 12 Apr 2025 06:09:14 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c670esm3446935b3a.69.2025.04.12.06.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 06:09:13 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, donettom@linux.ibm.com, Huang Ying <ying.huang@linux.alibaba.com>, Keith Busch <kbusch@meta.com>, Feng Tang <feng.tang@intel.com>, Neha Gholkar <nehagholkar@meta.com>
Subject: Re: [RFC PATCH v4 0/6] Promotion of Unmapped Page Cache Folios.
In-Reply-To: <Z_m3VKO2EPd09j4T@gourry-fedora-PF4VCD3F>
Date: Sat, 12 Apr 2025 17:22:24 +0530
Message-ID: <87jz7p1ts7.fsf@gmail.com>
References: <20250411221111.493193-1-gourry@gourry.net> <Z_mqfpfs--Ak8giA@casper.infradead.org> <Z_mvUzIWvCOLoTmX@gourry-fedora-PF4VCD3F> <Z_m1bNEuhcVkwEE2@casper.infradead.org> <Z_m3VKO2EPd09j4T@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Gregory Price <gourry@gourry.net> writes:

> On Sat, Apr 12, 2025 at 01:35:56AM +0100, Matthew Wilcox wrote:
>> On Fri, Apr 11, 2025 at 08:09:55PM -0400, Gregory Price wrote:
>> > On Sat, Apr 12, 2025 at 12:49:18AM +0100, Matthew Wilcox wrote:
>> > > On Fri, Apr 11, 2025 at 06:11:05PM -0400, Gregory Price wrote:
>> > > > Unmapped page cache pages can be demoted to low-tier memory, but
>> > > 
>> > > No.  Page cache should never be demoted to low-tier memory.
>> > > NACK this patchset.

Hi Matthew, 

Could you please give some context around why shouldn't page cache be
considered as a demotion target if demotion is enabled? Shouldn't
demoting page cache pages to a lower tier (when we have enough space in
lower tier) can be a better alternative then discarding these pages and
later doing I/Os to read them back again?

>> > 
>> > This wasn't a statement of approval page cache being on lower tiers,
>> > it's a statement of fact.  Enabling demotion causes this issue.
>> 
>> Then that's the bug that needs to be fixed.  Not adding 200+ lines
>> of code to recover from a situation that should never happen.

/me goes and checks when the demotion feature was added... 

Ok, so I believe this was added here [1]
"[PATCH -V10 4/9] mm/migrate: demote pages during reclaim". 
[1]: https://lore.kernel.org/all/20210715055145.195411-5-ying.huang@intel.com/T/#u

I think systems with persistent memory acting as DRAM nodes, could choose
to demote page cache pages too, to lower tier instead of simply
discarding them and later doing I/O to read them back from disk. 

e.g. when one has a smaller size DRAM as faster tier and larger size
PMEM as slower tier. During memory pressure on faster tier, demoting
page cache pages to slower tier can be helpful to avoid doing I/O later
to read them back in, isn't it?

>
> Well, I have a use case that make valuable use of putting the page cache
> on a farther node rather than pushing it out to disk.  But this
> discussion aside, I think we could simply make this a separate mode of
> demotion_enabled
>
> /* Only demote anonymous memory */
> echo 2 > /sys/kernel/mm/numa/demotion_enabled
>

If we are going down this road... then should we consider what other
choices users may need for their usecases? e.g.

0: Demotion disabled
1: Demotion enabled for both anon and file pages
Till here the support is already present.

2: Demotion enabled only for anon pages
3: Demotion enabled only for file pages

Should this be further classified for dirty v/s clean page cache
pages too?

> Assuming we can recognize anon from just struct folio

I am not 100% sure of this, so others should correct. Should this
simply be, folio_is_file_lru() to differentiate page cache pages?

Although this still might give us anon pages which have the
PG_swapbacked dropped as a result of MADV_FREE. Note sure if that need
any special care though?


-ritesh

