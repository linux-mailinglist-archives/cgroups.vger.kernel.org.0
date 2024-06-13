Return-Path: <cgroups+bounces-3175-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367B790639E
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 07:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E88C1C21696
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 05:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D024F136987;
	Thu, 13 Jun 2024 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WGr5nvc5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9281207;
	Thu, 13 Jun 2024 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258047; cv=none; b=Ysj7pgUvnwr6vFHX1GfHN0Ma656QNRXI0OG4/P63Qr4WWZpJRcHmyneVDdjcgVwTmoeR+PMNndu8zRW6YdbQd1EpBqaFPagCAOkLKrSY9cu4cBPPqIE244aYhpCJlqeOubFZ6uk1MPq5iQN5r3CFE3P/M2qbTzQvlJ19zPV1Hzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258047; c=relaxed/simple;
	bh=Bo9w9ZSL4zxjvH+deU09KFW+rBmKUUYyQumKsggz4JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwuzcLlf7PxhdOi1n0fC5TwrXfGM7tTyZLUEZjjcdUekqa6mFZyDHrM4HQVXVttK6HCuTtFjoOygnotu3l+yURJa1vSXFdOrQhUyfGGInZitMuAP7v/MABoxAKiG4F8EnxSuhCJujEePUwE8C98yGyfEj+IUQwHh7jey+KEAWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WGr5nvc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D352C2BBFC;
	Thu, 13 Jun 2024 05:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718258047;
	bh=Bo9w9ZSL4zxjvH+deU09KFW+rBmKUUYyQumKsggz4JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGr5nvc5uG9oy8c8Mh/Qn4MYJxwmEWgYqgXTs8RKe16rnpPhvqGTl4+VRnfRCXHPB
	 WgH1BK8tXCvcavqY1TRxtcQolrDItkI8nwOR+zAv211p+J9gEeT/UdqtDUGls0bFLw
	 SrE/T4iSUbhZm2VmJ49EDZSyJI7BP/Wo0a3pb7jw=
Date: Thu, 13 Jun 2024 07:54:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
	lizefan.x@bytedance.com, hannes@cmpxchg.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH RFC -next 0/7] blk-iocost: support to build iocost as
 kernel module
Message-ID: <2024061342-walk-cavalier-7e48@gregkh>
References: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613014937.1326020-1-yukuai1@huaweicloud.com>

On Thu, Jun 13, 2024 at 09:49:30AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Yu Kuai (7):
>   kernfs: export pr_cont_kernfs_path()
>   cgroup: export cgroup_parse_float
>   block: export some API
>   blk-iocost: factor out helpers to handle params from ioc_qos_write()
>   blk-iocost: parse params before initializing iocost
>   blk-iocost: support to free iocost
>   blk-iocost: support to build iocost as kernel module

No where do you say _why_ building this as a module is a good idea.

Why do this at all?

thanks,

greg k-h

