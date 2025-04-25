Return-Path: <cgroups+bounces-7835-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01D2A9CC78
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3FC1746C6
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 15:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E6226D4E2;
	Fri, 25 Apr 2025 15:11:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B464274642;
	Fri, 25 Apr 2025 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593908; cv=none; b=ECm43G8yV8NSLU/MQYQnybtD6LMzEba81kPbH5q0gNpvl5BxHniP/lW2onKECMCtTgjirRSBNIl1FeCprR4Ivffz9dKSQjVx+xAmz8/L5dJ0qM+fFW8YBD31qDWnkdDAw3O9vcS0jOEFRUuegp/9BMhZadw6zVoGOn+Qfbb67SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593908; c=relaxed/simple;
	bh=CA2lm5FtIXF+iTHuSgWS+yEwpbKDGYCiZzV0Gc/vSAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2NZU42n4/gnAWQTDGnCuCN42abcKfb6bN44SmoVTSQWuDmUQj+nxxQ9jSPX39yHVZEXlehEJPONzgTnl2zQpng4kcArA7bMJd9iWfiTv27pO/Mp/+rfhvWqnEewHOK0x7GDsMUPIb8CFPQzjB1jSgS5tV734DIGZLW2oMxrTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D3DDB68BEB; Fri, 25 Apr 2025 17:11:40 +0200 (CEST)
Date: Fri, 25 Apr 2025 17:11:40 +0200
From: hch <hch@lst.de>
To: Waiman Long <llong@redhat.com>
Cc: hch <hch@lst.de>, Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cgroup null pointer dereference
Message-ID: <20250425151140.GA14859@lst.de>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com> <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com> <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com> <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com> <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com> <BY5PR04MB68493FB61BF28B5268815381BC842@BY5PR04MB6849.namprd04.prod.outlook.com> <20250425145450.GA12664@lst.de> <3fef1073-3a7e-45ab-8448-a144d5fb6a73@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fef1073-3a7e-45ab-8448-a144d5fb6a73@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 25, 2025 at 11:04:58AM -0400, Waiman Long wrote:
>
> On 4/25/25 10:54 AM, hch wrote:
>> On Fri, Apr 25, 2025 at 02:22:31AM +0000, Kamaljit Singh wrote:
>>>> It should also be in v6.15-rc1 branch but is missing in the nvme branch
>>>> that you are using. So you need to use a more updated nvme, when
>>>> available, to avoid this problem.
>>>>
>>> Thank you for finding that commit. I'll look for it.
>>>
>>> Christoph, Sagi, Keith, Others,
>>> Can this commit be merged into the nvme-6.15 branch please?
>> What commit?
>>
> commit 7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list with 
> cgroup_rstat_lock")

I don't see how that is relevant for the nvme tree?


