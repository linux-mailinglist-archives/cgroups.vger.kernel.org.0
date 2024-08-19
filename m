Return-Path: <cgroups+bounces-4358-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE395774C
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 00:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CA41F24FEC
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 22:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02AF1DC468;
	Mon, 19 Aug 2024 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtydnUAp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9D1DD392;
	Mon, 19 Aug 2024 22:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724105809; cv=none; b=UyXchaojReqkXQP9slHxga7JOiEJhSy+WEQ+tOrR0Sxjq+TXYfo+kW/p2dCzoOjm8XgRV9yky7NtHmNLg9oDsZ+OKfGmQf4vWe+YZVuWSP0encMNnyE06l4eJ1eU7fMTYU/GPSXWr0BRVwpx6rr1Utq4Vo9l4V5ZD9cjsy84Ljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724105809; c=relaxed/simple;
	bh=Nzj+LfX9fQ4I6u8UfrKsEokzPiqN6N+T7dfDt0+HcGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1hmxKMPG0vZjgTSYK3aqI1QfGTDI8LFtnFHEHabqTNCUjyEmB6ehLLP5AarQQRZyh5A0E8c9lS23PPXnXDewcGQ5ATiQ9GK8TWqDwRVNnmFDIgFK9F19zJr/KK7V5S2iKu/bxHK9NxTj3E4qFvsyy61sL/2Tae2Eu2OTV4MFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtydnUAp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-202376301e6so11502075ad.0;
        Mon, 19 Aug 2024 15:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724105807; x=1724710607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1y5PlukJ+SOOumk/OeOAu3HmokrqkUm8pIwj2eltMFQ=;
        b=gtydnUApq2FYHRtPrN/llkKEwrApM0dGkObO3QuKAA2FkWYsfcYHvbz6CedTILIEij
         4koUp6MA9IKnHovs+BurFni0co8kSTc2W9sfVoUXk0io6KU82uZKwVA+DmXQzwUCHdOV
         WFikqkWCgmUO/c2FHqMR2B+9IWtrZcatcaQG036NBb46dvxoUd0PBdJDRxOZuoYgTH0t
         /HKgOIZ68SWx1agoHhUCdkG9L32iuKr722facINU1jfSqUtHc8MzzWKtQbzLS16xdLEh
         u3Q6S3L0kfEX7NG7MkKKrlv5ILmBMSy/kzzQvp3R9TRZaxepsoIoh+armD+LJGdsOgnR
         /f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724105807; x=1724710607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1y5PlukJ+SOOumk/OeOAu3HmokrqkUm8pIwj2eltMFQ=;
        b=oQIvYjFw4qlltc/3bWayM6N60psN4rp5I8vAVrRT7RVtiXR+71ToRGi8Tk03MZeTN8
         3D4q+F4qmUDIOneBzPHgUzxGUqegXBi3brFBL0cClqjHglRt2tGvHn/Me6ps1jMWqrNg
         OcoH0rzhV03cIIwNDG4+8sTgBameITrv6sPiuDhfGuTvAQedGGPnuBwdp0j+mw3vvTu3
         JNIvt6FUVEGkVKeBtCTO+ZqcC2ZTLWG1xzx+PKl/1mu7fEMXrLHys3HaKG0xUFUVRSAR
         ZMCcLke655hfzEwKe8LyFi/EdIyiNoJCGRZJmQ/5owwl9lJ540b0b3fFJrtp3zTE4wpl
         u0Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUQqd2tB2bkoZ2AZNEr8C2+qjHreKxSClEq50Q8wxiYSIuttMEjp6pBNeZeGlSFjSyEoVv4URs6@vger.kernel.org, AJvYcCX3eN9pCJ174GBCtpk+/Shqb0wclWvMGXm+4Fgil33789VB/bjdI6JUjkXnXXI9Idbx2VuNQdFuwmuRhn7e@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl6t3gWyOitPIe6UCdjtgctXq+RBBGPqgFsTZOluV3qtPzyYUI
	qEpL8akZj1VO/cdBfRsI1vYWF9zsvzDijlhfz7e3Ed0BS9O6P/hkvpRVWg==
X-Google-Smtp-Source: AGHT+IEGVnvKsQpc89YddCI2AsmSWtFvjvP2OkaNjfnWPY+W5uWvms2kpi+lBtJrvCygDGU1tqtYsw==
X-Received: by 2002:a17:902:e881:b0:202:38be:7b20 with SMTP id d9443c01a7336-20238be7c70mr43545105ad.38.1724105807116;
        Mon, 19 Aug 2024 15:16:47 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03793b6sm66617345ad.127.2024.08.19.15.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 15:16:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 19 Aug 2024 12:16:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] cgroup: update some statememt about delegation
Message-ID: <ZsPETdWAlUu2tDIU@slm.duckdns.org>
References: <20240815131408.3151804-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815131408.3151804-1-chenridong@huawei.com>

On Thu, Aug 15, 2024 at 01:14:08PM +0000, Chen Ridong wrote:
> The comment in cgroup_file_write is missing some interfaces, such as
> 'cgroup.threads'. All delegatable files are listed in
> '/sys/kernel/cgroup/delegate', so update the comment in cgroup_file_write.
> Besides, add a statement that files outside the namespace shouldn't be
> visible from inside the delegated namespace.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Applied to cgroup/for-6.12 w/ text reflowed for consistency.

Thanks.

-- 
tejun

