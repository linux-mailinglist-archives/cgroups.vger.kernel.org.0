Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3E32F86BF
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 21:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbhAOUdQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 15:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbhAOUdO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 15:33:14 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B372C0613C1;
        Fri, 15 Jan 2021 12:32:34 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 186so12989107qkj.3;
        Fri, 15 Jan 2021 12:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DZutw0Fwx8a+IIzb1YBWXpa8GKgVuQAFbe/fVJQB0Ps=;
        b=jVJdbkknWSYllAadoPc9Oy1txnskyomnVDMqBHvc2sZDhifPs0SUcyQf2fk9LvmiFo
         0orrMluvStZK49mX/Vn0roCZHVneqQt5UXix5BVwB1bdpUcmsO0pvx/9R4u5ACiL+xX8
         Cx99+k0xhFvAa6davOP6vhdJ07pKYsZ6raS7j4mb0gKnyQkN9WWXe4/3AidyzfSX+s1s
         fTRnLIu5nwcKx0vE3HZB6lyqH0kMIyFrTOoAb3Tb5kDJBy9VnTqKBj7+TL9mrfxZ5vr0
         v1u2xbqatdluGdM478vbBXnN6QhFnlPAKEbxVHXBhgJGxf7X3871nTvXe1n0frlSroRl
         iGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=DZutw0Fwx8a+IIzb1YBWXpa8GKgVuQAFbe/fVJQB0Ps=;
        b=rOdTZHVXaq771xjdAk190lFKcDO7FaYDlpvq+pUnJDNLS4V3GOS5cGb/doK2eB5rQm
         vD4XAuA30S86azyN9MamBUXjPnMN30mNgtuaN5UVltp8ay9USkcm2hqtr2yGZSQ52Asv
         XwEAUszUAQlqsXJmRojO2hY3VU6zMLEPrr9uUXG7jNVhiRYDEMHw+4LmQV7IU7EMXfmA
         lH2pukCTaM8MSVgELxJUPNlsSpbDPVH44sR9Wve96F+CSq8hmj/MqXi5g3k2oDY3dME7
         0Rx1v1k04h8s//HB9QoPgWKs73kKsrLeMSruVANF61JLqngqZZHElVk5KiF3QoGz4kyR
         pgEA==
X-Gm-Message-State: AOAM5311TZCHZvNn6aZSskzBflGFiCbfe+2AexSH/bodR6Y9nJPenzNH
        DfGhMp+u7OhKZxYS7yc0x3c=
X-Google-Smtp-Source: ABdhPJx92D8iiN5sSjvzqpFf9NdIEL/hiHJtZ9wHqT4F30AjuaYj6vToFtYZCgLagNaAD7kvA+3ekA==
X-Received: by 2002:a37:8485:: with SMTP id g127mr14147073qkd.233.1610742753543;
        Fri, 15 Jan 2021 12:32:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:97cc])
        by smtp.gmail.com with ESMTPSA id n36sm5361265qte.71.2021.01.15.12.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:32:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 15 Jan 2021 15:31:48 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Hao Lee <haolee.swjtu@gmail.com>, lizefan@huawei.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Remove unnecessary call to strstrip()
Message-ID: <YAH7tIWhfolU6EzM@mtj.duckdns.org>
References: <20210103024846.GA15337@haolee.github.io>
 <YAA8qyBUAurgCeEz@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YAA8qyBUAurgCeEz@blackbook>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 14, 2021 at 01:44:27PM +0100, Michal Koutný wrote:
> Hello.
> 
> On Sun, Jan 03, 2021 at 02:50:01AM +0000, Hao Lee <haolee.swjtu@gmail.com> wrote:
> > The string buf will be stripped in cgroup_procs_write_start() before it
> > is converted to int, so remove this unnecessary call to strstrip().
> Good catch, Hao.
> 
> Perhaps the code be then simplified a bit
> 
> -- >8 --
> From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
> Date: Thu, 14 Jan 2021 13:23:39 +0100
> Subject: [PATCH] cgroup: cgroup.{procs,threads} factor out common parts
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The functions cgroup_threads_start and cgroup_procs_start are almost
> identical. In order to reduce duplication, factor out the common code in
> similar fashion we already do for other threadgroup/task functions. No
> functional changes are intended.
> 
> Suggested-by: Hao Lee <haolee.swjtu@gmail.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-5.12 w/ minor description update suggested by Daniel.

Thanks.

-- 
tejun
