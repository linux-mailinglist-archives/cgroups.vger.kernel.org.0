Return-Path: <cgroups+bounces-1727-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AB485D59C
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 11:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C74C1C21AC7
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 10:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3599C5224;
	Wed, 21 Feb 2024 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C73AFeeK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06413D7A;
	Wed, 21 Feb 2024 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511639; cv=none; b=SRvLb2v955WECo/VNqSgdkRPoXaEsaKUb7wm9Ripbs/say02/AzROxI0utbl4OCsoDqt10GYJlDeG2Pmwf6Glp5GcmQa8YF+txfwhXaahlXnz3kWzmAB1/MiLlG5njalj3bVEtUOaCkfz9OUdVX2eW1d6sfODb9f2lLSLqrSscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511639; c=relaxed/simple;
	bh=BOPSX0/N/WnBv1zcyAER1JjpAJ3iH3Gs6X63CUetxWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJCJj+/GFw9QNTZuOzK8Mvb01j68keW/c4C4RdvSOKMILVPCqyIKkBjkrUzHgiicWrh+QBnyxKTnhKr4ORkILbUe5J0FHpAf6if/aEwd06qsviw9W/M0wfkMPx08eCtrrYqQs3nVoSKy9UL4N8TNraAbKs4MJuDlF/QIIqs6Xgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C73AFeeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FE2C433C7;
	Wed, 21 Feb 2024 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708511638;
	bh=BOPSX0/N/WnBv1zcyAER1JjpAJ3iH3Gs6X63CUetxWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C73AFeeKkCoRVPJGqiRkIGzoxp4r26M9sOXnk+gDOX3bMVNFu/3CbMu6amn/EjjJF
	 JW18d1eHmrQet7XbcdlFI4HZGyzr7wqo7jwYt3PobKeVRcrvSTW1/PENAFzlzbUWD0
	 5X7ix4EZs1sYPNTV7RG6a3RAx2dR/rcCPyvN6w90=
Date: Wed, 21 Feb 2024 11:33:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH stable] memcg: add refcnt for pcpu stock to avoid UAF
 problem in drain_all_stock()
Message-ID: <2024022134-tackiness-earmuff-59ef@gregkh>
References: <20240221081801.69764-1-gongruiqi1@huawei.com>
 <2024022119-bogged-action-c877@gregkh>
 <ZdW4xR-Ke227pxjG@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdW4xR-Ke227pxjG@tiehlicka>

On Wed, Feb 21, 2024 at 09:48:05AM +0100, Michal Hocko wrote:
> On Wed 21-02-24 09:40:29, Greg KH wrote:
> > On Wed, Feb 21, 2024 at 04:18:01PM +0800, GONG, Ruiqi wrote:
> > > commit 1a3e1f40962c445b997151a542314f3c6097f8c3 upstream.
> > > 
> > > There was a kernel panic happened on an in-house environment running
> > > 3.10, and the same problem was reproduced on 4.19:
> > 
> > Now queued up, thanks!
> 
> Give it some more time Greg, http://lkml.kernel.org/r/ZdW2gMajIw_cUN2-@tiehlicka

Oops, now dropped, thanks!

greg k-h

