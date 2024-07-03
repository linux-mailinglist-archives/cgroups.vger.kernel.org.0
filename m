Return-Path: <cgroups+bounces-3526-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B501E926795
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 20:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F9B219DC
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 18:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D41E1850B1;
	Wed,  3 Jul 2024 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMahwZi4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14E17F51A;
	Wed,  3 Jul 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029783; cv=none; b=CnfzSs3JM1eeFN7q4mwUo7MGM11wQeS1KoD5thdunTGxyhFEvENkq026wWhrRiuxpEygB1UhtFfwpBTnI9QjbtDgiIYvk4nQomciaDQaajxRCFvALXAlwOfBSyMPmka4NMpEtJ3avDQxJpthKQJOfJUVhPqnxAtRQyDDsxpODAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029783; c=relaxed/simple;
	bh=B4ySoAt9XmANvoGWAWLu/nneuZIPT9MWsIZhcy351g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXVLEyq/M0Wx4FDi3/HKVio8QYb4dpjomD1GHsylKj2lVlhaw9RSr35LetgabHcmLnxWArNKMKLFyDdD1CsMQ24cXMqlDOOj9DqfTWILfPYOfASs7kH2kqdf7zcLB8omtLkEG8cOHAiTMGJOTph1QMmYFki3bay8RZkhw1uRJog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMahwZi4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f480624d0dso42580355ad.1;
        Wed, 03 Jul 2024 11:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720029782; x=1720634582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tcGACeNmDpmXt5A0FQZMjSRiXosaejWpJz9GzTjaGM=;
        b=PMahwZi4jWVqZiP/eDZ5/y68Xn/6FcSCyMY2V0XIdwo+2VwmlHoBYMWNu7mVoYFd8O
         Q4SEFBKlbZeUXdBiZ4ta71AgU5uDuaNrbVV+aKk2QTDMyMtaObE6ng18jdaDPDB+25Uv
         WqUUsswFIOxN3EroqnqLNp5TRprcdg1aiFanCIDEZkLFigmIII6Xo27su99YNp/NOXA/
         cZJqiUpv2i/aOQOOT8U6A31uSDQCxkzx35UCnLusTi5PhB6bbiIQI4LvGQ5WBOMeqxKi
         NSZGCe+4/2HauKJdp0QHg0KDQX2Dtg+oPBdDEiZ0rpjZ0tuwD7k4TLWHjVz9eZq+Etif
         ebqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029782; x=1720634582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tcGACeNmDpmXt5A0FQZMjSRiXosaejWpJz9GzTjaGM=;
        b=exVl4y8MI3UiDQZ/znux0w4A10Ps696lAUY6G0rltQidTifoG4sW7c2LA5vZB6rvXl
         A1mG3BWVWHpLkVfhhLOGWPtzfjwHYoPGAJ7xwf8k2xLFQJKTHltM0v2I4VMWdf9hmYux
         K887zAHkY20kqxreagzQegRkNNHqyRDWC8yxe+hsqmt/CczibztH8VuV0KGOYoW9oQfM
         AEVHSjcgM/om9saLCaFSZCQo0MgNL7ozf/Wr3w6hbPi8MnlPqkYtWkhdMa/c5riQYjq/
         CkduPWyJ9PqS1W/uCRkZMtMKBT9ikKEtq9hPgILSw7muSel7OBiqQwhh/pMZWd51AhqE
         +j/w==
X-Forwarded-Encrypted: i=1; AJvYcCUP7Jk4GBvs4ZaalWu56PGfDBaRTtKYIrQZ2G+c7Wv1R8aTO9nMcvvMPnarjc+coRhlm4PFOu82jzxRMWsX/pu+a9fWdqu2ox0dP7uqcCRJYPfGOVd9d8g8EUvRAzwSgoZvaeAH2ZJ07+4/8UeSJr502InYlUdJW7iBGjxcxvAsqg==
X-Gm-Message-State: AOJu0YxrtXAFOC5eWVhuMJWXq+dMuKy3Z4448MeAdudYidIvJE/okWvE
	GXpzns6UygrD51EzGtuFL7IuSxJ9V4KrMzI71wt8CHQBmtAdghDJ
X-Google-Smtp-Source: AGHT+IHW8duCgfxpNSBcSxGCOya6xMeTRKi6A9lNKI3gjQkupFrI+ydS7Da05DnBQ/GHUOAGffdTYA==
X-Received: by 2002:a17:902:c40e:b0:1f7:2135:ce71 with SMTP id d9443c01a7336-1fadbc5be50mr136998785ad.11.1720029781697;
        Wed, 03 Jul 2024 11:03:01 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1438sm106337435ad.24.2024.07.03.11.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:03:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Jul 2024 08:03:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, corbet@lwn.net, haitao.huang@linux.intel.com,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 -next] cgroup/misc: Introduce misc.peak
Message-ID: <ZoWSVBVAbQjW0l34@slm.duckdns.org>
References: <20240703003646.2762150-1-xiujianfeng@huawei.com>
 <cb6bc4b9-bbf3-4d43-aeb8-8efdcbf94a9c@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb6bc4b9-bbf3-4d43-aeb8-8efdcbf94a9c@oracle.com>

On Wed, Jul 03, 2024 at 03:13:29PM +0530, Kamalesh Babulal wrote:
...
> The patch looks good to me after the atomic conversion. Sorry for bringing up
> this question so late into the discussion. Given that misc.max is available
> only for non-root cgroups,  does it make sense for misc.peak too, available
> for non-root cgroups only?

It's more tied to the usage - misc.current. For memcg, memory.current is
only on non-root cgroups, so is peak. For misc, as misc.current exists for
the root cgroup, it makes sense for .peak to be there too.

Thanks.

-- 
tejun

