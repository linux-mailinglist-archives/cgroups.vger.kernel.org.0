Return-Path: <cgroups+bounces-7833-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EEFA9CC1B
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 16:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA5C4C6911
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC492580EA;
	Fri, 25 Apr 2025 14:54:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12802580F9;
	Fri, 25 Apr 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592899; cv=none; b=haWBiynjopMy34zHsmxe+yzPuP+nU3cG4KEAfIxPSPw3KrP+tt6cfiTRvq+AVhSYBsFXjFdyjopEmKqCYPEMXjoUNaq6Epssx4xDL1lRTG0AS1/RFbAkm/0O4ApWUWK50VjzA5OX0mXJ8/dD/zxgSK6L7zTk9FShq3E4sR/YvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592899; c=relaxed/simple;
	bh=dRE45UE6pb6M/g3CkrnQM1V7s7IWXP4ZfxX2a91cle4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOIpUC2h4UUovN1/JbBbUyrUg4+Kw6b3wmTHe3bEbw4zDK8Blw8sQ8NnHcdXsrYTsI3GCTFMfmSlV04qlZx8YfcxG5av/ySnbp9HbYEol9F67n2ct59KfyTu5IEY249gyofOQ19n0nRW8DgbSo5Aeexou8nNSYYGTJ2V3+Qtsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6494568BEB; Fri, 25 Apr 2025 16:54:51 +0200 (CEST)
Date: Fri, 25 Apr 2025 16:54:50 +0200
From: hch <hch@lst.de>
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: Waiman Long <llong@redhat.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	hch <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cgroup null pointer dereference
Message-ID: <20250425145450.GA12664@lst.de>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com> <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com> <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com> <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com> <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com> <BY5PR04MB68493FB61BF28B5268815381BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR04MB68493FB61BF28B5268815381BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 25, 2025 at 02:22:31AM +0000, Kamaljit Singh wrote:
> >It should also be in v6.15-rc1 branch but is missing in the nvme branch
> >that you are using. So you need to use a more updated nvme, when
> >available, to avoid this problem.
> >
> Thank you for finding that commit. I'll look for it.
> 
> Christoph, Sagi, Keith, Others,
> Can this commit be merged into the nvme-6.15 branch please?

What commit?


