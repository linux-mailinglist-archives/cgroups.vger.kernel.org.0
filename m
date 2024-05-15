Return-Path: <cgroups+bounces-2917-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AE08C6B08
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 18:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E052B1F22E22
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C417286A6;
	Wed, 15 May 2024 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4Hku+1V"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091425745;
	Wed, 15 May 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792073; cv=none; b=es4tpsUa7uZudX037/+p7e1x74niBxxlQv+HghjNGBkVdQct2B2GqLvF6UOioaIln3rOgEtrH1hKY++Xvfl92e28X+0jtdFUSpzotBwm6wq4Ml0aVz339HKbvaVsP8/TLx8mj9BvLVd1+svOjw/ysWgT1Pp6XixNBpv2j4OOx3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792073; c=relaxed/simple;
	bh=GIs5f+xsHD3yOfMod+xbtSvQ2IUmiMI6wy1enZJNPhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRcsOVBiJZWF9/n8W9eeErUOnKMnFDsEdmB3SA6BqGrM7IYTKFuGrb6WtT5gMRK1lDbaQlAfO5kUVv9e3k2ePpM9ULXAV1tw03EdQD1Q4mse23Hr4HIO1MoifAzyVWO/RqokwUWf1K5dmjt0mp7DZN7HfP3/La/+UADCXRzTVnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4Hku+1V; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b5a87505cso35165476d6.2;
        Wed, 15 May 2024 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715792070; x=1716396870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQJvos9LzUCKd6k0Vowf3gtRs6yQddQLHilrv8BeO1M=;
        b=G4Hku+1VFLIjUe0hk9oOZKBywo4AYPOr8FJ5h2+L4t3zLlm5rfXqENOpDoZmhIBojP
         Zk3wLgQx2Z+0iU2SaRT6d+TAXUWJemnw9GEcb3q81ipFHn7VWa1zfp2FTy3+dxp/Z8l+
         IGb7EY9uDAUNVkbs0wUZIDHL+47iTLj1T2cIzZBK+ZYaHAv7H4dvrKlAqufR+ICcrLtG
         0pMdvjTbx9MAaM32R3m88aUt/fINVNLZcWUj1i5abwdHN+8RZlTo3kHCWDJ0rtyA6Nh1
         IGW7b9OuY5Bcgc2qIbkbaINZcfTaxuPidWE84EIWxdNy84DlH5L21N0s5qLL+/3fmTml
         8Wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715792070; x=1716396870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQJvos9LzUCKd6k0Vowf3gtRs6yQddQLHilrv8BeO1M=;
        b=aSRlZKphSDhqt7iJLb8UAStPhvjQqoKP9TOHBS/Gl3O39+3/6AhZR7kxlf9cb5Gjxy
         nteUCS5LIvd3gDWCFlfrmZPWzforC3IdpX7HFa01A162atJI1M5ncD29qsa5n9bYbVzL
         I7m6lIZeyeY+CbchbUIhvOdRbV59+KBFAeI6ipmSfCIZQAJkaPxPHxQVWwF3nwExBVW0
         qw5x2WEVKyTTiB7RyvNrHMi1lXKG2/7gCrSCX4jXkVjbno9vrZPV2JJ+Gqa37cWvY8El
         nDgjIbLLi/u4q4Uq2vrzSjHIDf6kXLJ4ZvQ/BGWOoMCgi4YDA53kwsgLdG5qTWUFkbHn
         Wxug==
X-Forwarded-Encrypted: i=1; AJvYcCWpzyHwSz6WQdCUp/pHk3He0yfXtqdMNfWy7cK5ywdjquIO4CVsLTSUP2360yxELmSLhzpoVsx9MPpPDnelRfNcrn4Yd47nOJXoSPE+jYdYX8GA9Um9YF3xPZigDaetbjCUQeiAzEoeIrV2MnYKNuzS58cOppLOSiMDIFthAoxU75I1
X-Gm-Message-State: AOJu0YwGsP+qCt7rXHd8WXVQfb+eGiusPhXyQo7OguNFi3aW5qXgQRxL
	ahRAbk3GkifL1mYUerWDlmDpXnssdXIq6DTFuvSpiVEhKe1g6JB5
X-Google-Smtp-Source: AGHT+IEE1oYzjigoTHOCCbcBU4OmR2uyKJi2zA5od8ycqoeHeXEqOxYf4KpPPsXy34ZTS2qvCgoKyA==
X-Received: by 2002:a05:6214:4602:b0:6a0:e827:d8e with SMTP id 6a1803df08f44-6a16822b743mr199727976d6.40.1715792070616;
        Wed, 15 May 2024 09:54:30 -0700 (PDT)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::4:d26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f194da1sm65087116d6.67.2024.05.15.09.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 09:54:29 -0700 (PDT)
Date: Wed, 15 May 2024 12:54:28 -0400
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: cgroup io.stat propagation regression
Message-ID: <ZkToxDuKxSPEg5aP@dschatzberg-fedora-PF3DHTBV>
References: <ZkO6l/ODzadSgdhC@dschatzberg-fedora-PF3DHTBV>
 <3ed32279-904a-411d-91a4-a62f4ca2dde2@redhat.com>
 <11b8c1e4-45a7-4895-a1f3-6626744cee1e@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b8c1e4-45a7-4895-a1f3-6626744cee1e@redhat.com>

On Wed, May 15, 2024 at 10:26:31AM -0400, Waiman Long wrote:
> 
> On 5/14/24 23:59, Waiman Long wrote:
> > On 5/14/24 15:25, Dan Schatzberg wrote:
> > > Hi Waiman,
> > > 
> > > I've noticed that on recent kernels io.stat metrics don't propagate
> > > all the way up the hierarchy. Specifically, io.stat metrics of some
> > > leaf cgroup will be propagated to the parent, but not its grandparent.
> > > 
> > > For a simple repro, run the following:
> > > 
> > > systemd-run --slice test-test dd if=/dev/urandom of=/tmp/test
> > > bs=4096 count=1
> > > 
> > > Then:
> > > 
> > > cat /sys/fs/cgroup/test.slice/test-test.slice/io.stat
> > > 
> > > Shows the parent cgroup stats and I see wbytes=4096 but the
> > > grandparent cgroup:
> > > 
> > > cat /sys/fs/cgroup/test.slice/io.stat
> > > 
> > > shows no writes.
> > > 
> > > I believe this was caused by the change in "blk-cgroup: Optimize
> > > blkcg_rstat_flush()". When blkcg_rstat_flush is called on the parent
> > > cgroup, it exits early because the lockless list is empty since the
> > > parent cgroup never issued writes itself (e.g. in
> > > blk_cgroup_bio_start). However, in doing so it never propagated stats
> > > to its parent.
> > > 
> > > Can you confirm if my understanding of the logic here is correct and
> > > advise on a fix?
> > 
> > Yes, I believe your analysis is correct. Thanks for spotting this iostat
> > propagation problem.
> > 
> > I am working on a fix to address this problem and will post a patch once
> > I have finished my testing.
> 
> Actually, I can only reproduce the issue with a 3-level
> (child-parent-grandparent) cgroup hierarchy below the root cgroup. The dd
> command is run test.slice/test-test.slice. So both test.slice/io.stat and
> test.slice/test-test.slice/io.stat are properly updated.

That's correct, this repros with a 3-level cgroup hierarchy (or
more). systemd-run should create an ephemeral .scope cgroup under
test-test.slice and then delete it when the dd command finishes. So
test.slice/test-test.slice was the parent (2nd level) and test.slice
is the grandparent.

