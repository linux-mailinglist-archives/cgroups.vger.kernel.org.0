Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E52F865F
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 21:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbhAOUMr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 15:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbhAOUMp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 15:12:45 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5EFC061757;
        Fri, 15 Jan 2021 12:12:05 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c14so6966116qtn.0;
        Fri, 15 Jan 2021 12:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nwZUHOzxfZQxlqIcBZBTaBRxR48aAaQTr4GFdmPla/o=;
        b=XhLNFQOaif4Y0uy7rduwG0XPxHM3IWWhRsuje0KoDdBE8uyJjD3QVeA58vUc3LdWfP
         b65+6MLKVmTZ7UsyoV79W6/2QXcm19ftztAQLLz2002HxEM8IBdLvcT7Psohbt2lFbqS
         eqosBwYIzo2vLv6x7VB7ikPkwDmwWigAXzDsvkZ1njY9RnZ2w5CDDbFiuKZdOrGPdf7o
         qtTCflIqyndRj+7jhG5/mY9YqxW5jt1YHfn69lFvp78EL7NfkZqUQYt1eGjpqXrpmnjM
         CgsUeuvmMvLIVdJ8hqKTUBYdMSdgJQd34V9/7oJ2LXUOeoC1g23usnGLC+x/Wpph1ykg
         NCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nwZUHOzxfZQxlqIcBZBTaBRxR48aAaQTr4GFdmPla/o=;
        b=gg86DDZ75iUfr5tlU1ghNnUR0wQTER8RTx7zQgZmuHU0PtZZKOdQFprRB/2nh22jDg
         eaPFXS9SmWzrP1EPSZ8np4FGXzN4pmc/8qVMCus7EeWyTIC/V0xYZzjEhVk6RYdjlPHR
         EQ5nHHsXGGuds99ITb7ImExfjc15n5ElHrmuDLCw5ebeDZK2XFGu+UFjFzwBOtS6lBpi
         PR5BInC5NZSmA4/3oLzDH3Cit2LtGKb+oZr2bUWxT8/Ee6/xmiJfT1FSIfsdy79pbCmg
         hE+W7iQo+rlGBZNlZU0oV0Yjtu0BeeyTRc+svJzdxtDyOObJaBJDzAPUbJ2WN73dY+O1
         k14A==
X-Gm-Message-State: AOAM5320JHg1DH3iGc+MCoTUmQdjfzWp9UVBQ1SDeK5sYCZK/SrGRSXv
        VCyMTVK9acbmLtWSjy7U5eCpi0Dkbpk+Wg==
X-Google-Smtp-Source: ABdhPJwsbU2azBDgaKkkpQwzolx2xrDYuX//3qh+cXJ0virsJgqbV+U86uyLmEqlA8WI4BN6HCHttw==
X-Received: by 2002:ac8:1386:: with SMTP id h6mr13313729qtj.95.1610741524460;
        Fri, 15 Jan 2021 12:12:04 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:97cc])
        by smtp.gmail.com with ESMTPSA id v5sm5699753qkv.64.2021.01.15.12.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:12:03 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 15 Jan 2021 15:11:18 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
        viro@zeniv.linux.org.uk, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH v3] cgroup-v1: add disabled controller check in
 cgroup1_parse_param()
Message-ID: <YAH25uulZr1BiQVc@mtj.duckdns.org>
References: <20210115093717.79474-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115093717.79474-1-chenzhou10@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 15, 2021 at 05:37:17PM +0800, Chen Zhou wrote:
> When mounting a cgroup hierarchy with disabled controller in cgroup v1,
> all available controllers will be attached.
> For example, boot with cgroup_no_v1=cpu or cgroup_disable=cpu, and then
> mount with "mount -t cgroup -ocpu cpu /sys/fs/cgroup/cpu", then all
> enabled controllers will be attached except cpu.
> 
> Fix this by adding disabled controller check in cgroup1_parse_param().
> If the specified controller is disabled, just return error with information
> "Disabled controller xx" rather than attaching all the other enabled
> controllers.
> 
> Fixes: f5dfb5315d34 ("cgroup: take options parsing into ->parse_monolithic()")
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Reviewed-by: Zefan Li <lizefan.x@bytedance.com>

Applied to cgroup/for-5.11-fixes.

Thanks.

-- 
tejun
