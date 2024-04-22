Return-Path: <cgroups+bounces-2654-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A3E8AD549
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 21:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA07280D4C
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 19:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6A6156226;
	Mon, 22 Apr 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikuURnPJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E071155752;
	Mon, 22 Apr 2024 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815546; cv=none; b=QjMtdLcr7yrlMDeffoSEuc7nZrvSs4BiI8AGJC3Ga79N8fA192/2By3PkQE6mhO6hrwzMI/3EI0xOp0f2tbukKaBKwmktSOEPOEBWaqw1tMUvPZiKH3MUR2lrJAfwQczb21qYa/NOvCD/b+OLGwnyp/OQebmFido0QtmzoV23j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815546; c=relaxed/simple;
	bh=LNdpfWpGGQSV4DF9n4X+sBNvYWLDN87wEYe7NixA0qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8EHxVpiXISsAnK5NdiQp7XWCauzAMSU+0yVF+f1H6gR/dNY5+mE4FJSTmQJD1r952gwwxPNiNIjwnzVkbb+CAPxMtvOJmhJRbyOeYY2eO4E/qG1FxMUb8Wh4WqXuTjBqlGd/IVpj60nyFJwTRLqVDrYAgVzm9R/Ph1d6Rr/zak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikuURnPJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e8f68f8e0dso20491645ad.3;
        Mon, 22 Apr 2024 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713815544; x=1714420344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68NfI5IJiqhZpxzEB090wfQW0MtGnY2YVgkxhAQEuIw=;
        b=ikuURnPJkTZ0WaroV14xzDKDIBxpFkJTdNRBpiGJQmI3nEayEXcAzAdtpzjGU9Mn8A
         mXlVuMdGEulbgb8SAHqEAHf0yafIAyankBgXxqbPz4ZiIsH4v3CSx0OK4ScltuoEUIOh
         IDz1wwX2bMJfnXoRezswWdN5FbJ9VZK6D5cno9ZY9jJZYV3Fsqv7uh5r0CdqDr3BFsid
         APXQnj0+UJaBAim0heSCYgES0BjlO9q5VUZ40/cqu2EdIrbjm/dX8oN1wDkTsAvnA0bT
         4Swb37b2Y+vkjeAf4HAe2HpyTrk6omIx4cRh5xDr3hp/zdyPeFsLXtKWXbKFNWZIb/XK
         2UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815544; x=1714420344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68NfI5IJiqhZpxzEB090wfQW0MtGnY2YVgkxhAQEuIw=;
        b=XcCIgUet54ZDsMGKBsX00fxIopcaRk7XED2XdbOMfN58u6IhGPPa0aSepicFGwRW02
         3aryVBvMG1hThSfRgdjuyRiI4YhQ0Ik3CYsok/gO7owoo94HvvxaBdmaig400ibERfci
         WYhtc3BGy1vD+OeCvxzYAnL0CU/OGXQjB4rUfB22YqN7Hq+pnjnL1lMHldVCBHwVVYzK
         JkR2/IoYWUHfLt62gvtWQdbYYb3loBUa2b6i2ocOZIGX31VMgSh4JLBg8kGghllx/XRQ
         WCgzTxs55k80jZp+yezyf3wouAggSM6n6H3pnoMU22kaJVa7AvY8RanNl8RQgFntzpnd
         7wyw==
X-Forwarded-Encrypted: i=1; AJvYcCVtzARLDWF4vTVLMxNfIkDyfySH+2afNvZSZGzimJZoXNDSbXx+VcpW3c70Zk+YOammfNJDDYzDSWk6vx//jj9e74/MQ6AKpEP7xv2kKW/ResxUNODv6Yp/jp6xg7VkeKzZ5GxvLQ==
X-Gm-Message-State: AOJu0YzIoy5EZ6wsTWNxWDfbxxL2E+MV8n4vgrbdrfz1IiV0TkmZ207/
	T+0uQ8nsRA8SmQSSzX/6dKQts1ywhcxcY3ebxUi7RKuiTJQbAA1M
X-Google-Smtp-Source: AGHT+IHMLs9QxnWp6xH7muIu3RMeWdJrqCpFyWPHP5zkYZeHIac/vk0VtWjbLeEyaWRLjeeuWAwgsQ==
X-Received: by 2002:a17:902:ec83:b0:1e9:a0ce:f618 with SMTP id x3-20020a170902ec8300b001e9a0cef618mr4485622plg.69.1713815544283;
        Mon, 22 Apr 2024 12:52:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b001e668c1060bsm8497797plh.122.2024.04.22.12.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:52:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 22 Apr 2024 09:52:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/cpuset: Statically initialize more members
 of top_cpuset
Message-ID: <Zia_9nYxtJdrS-eQ@slm.duckdns.org>
References: <20240420094616.1028540-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420094616.1028540-1-xiujianfeng@huawei.com>

On Sat, Apr 20, 2024 at 09:46:16AM +0000, Xiu Jianfeng wrote:
> Initializing top_cpuset.relax_domain_level and setting
> CS_SCHED_LOAD_BALANCE to top_cpuset.flags in cpuset_init() could be
> completed at the time of top_cpuset definition by compiler.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

