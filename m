Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112D336298E
	for <lists+cgroups@lfdr.de>; Fri, 16 Apr 2021 22:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbhDPUmg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Apr 2021 16:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbhDPUmc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Apr 2021 16:42:32 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F565C061756
        for <cgroups@vger.kernel.org>; Fri, 16 Apr 2021 13:42:07 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id h13so11587148qka.2
        for <cgroups@vger.kernel.org>; Fri, 16 Apr 2021 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XB7njt+oGvZctAMxlmgcAtP5yDpC3NFFKZ6SHAuxUDM=;
        b=Jxemyxd9Q7CqrK7A61vstQkvzmVDdkSAa2JDVElwLoSy6GSWrakwVG6tqvpBp6X4aQ
         rR1RR9yI1flIahOxrdJYfskfdFcg73imCsSBMwtuAP1Vrt276ElpzgGF9FkKrBlaSZfQ
         JtmP5TZ9bTmUu1FW7GCme7m/rF8r5Rzi4r296Ds+iHb8m4+K2ZrULrig1Z4gbJ7+9ey1
         QlWQQsBJVPToRapQTjnAXHH6ZFIvic8Y5SKjLCJ+8HnM522Nrzdbz9Ke2Okn3EAMtUlw
         2q+BdrMNopvgne0A/gCueLfJzXkhNcgFqIcPoh8C/1f1UKS++SlzraTHZQOKRW7h4mv9
         /F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XB7njt+oGvZctAMxlmgcAtP5yDpC3NFFKZ6SHAuxUDM=;
        b=BjwIbhjW3XacEtHCXWFE0dw1SjUZWX/OIpYdMa+/EtYT15rOrbwhZHHkL8VLOwKPIe
         m15ZOrlOWMNab8+oa+eH/O4r3FCv16DotcQ19KdocQas++aqnWtGRcon7DZkwjY3D8Zk
         KAjXC7JMAPx2N2kLxqM2bVZcpThoiwrz65lTkb73CQ3as5QAv+/x/3M2sg7DQUfMQHY9
         676NFGUkSJa9ySTmq0+0Ed9i3Mgi6QyKdtYrjxdjCn9PidwvRWS+KooEsM5/xpJ3V2H+
         nNO68N/sMPB+1O1azfgkuZhuAlR6Q8k24hH0nTB2vFobA1lW2z3uY3cqtMsEJaUqW8rC
         5AgQ==
X-Gm-Message-State: AOAM532zBs/Eg3yPejEkjvw4XHvBKW2WtopdkaPkJYShPsKPAHOST1uj
        AcgO/DPTzX0lyxMXRHXKKXI=
X-Google-Smtp-Source: ABdhPJz3FRKRoeSxfJq0cdzOcXW1M3AXhzJQjjHf000C0qQezlvQn16G41KiF3rnTr4ckxTsqKnVBw==
X-Received: by 2002:a37:76c2:: with SMTP id r185mr1103758qkc.204.1618605726083;
        Fri, 16 Apr 2021 13:42:06 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id h8sm4539608qta.53.2021.04.16.13.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:42:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 16 Apr 2021 16:42:04 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     kbuild-all@lists.01.org, cgroups@vger.kernel.org,
        David Rientjes <rientjes@google.com>, lkp@intel.com
Subject: Re: [cgroup:for-next 1/5] kernel/cgroup/misc.c:61 valid_type() warn:
 unsigned 'type' is never less than zero.
Message-ID: <YHn2nDHqakJLG3di@slm.duckdns.org>
References: <202104131244.3qFwbTtx-lkp@intel.com>
 <YHU4XrOW1dBIZfVl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHU4XrOW1dBIZfVl@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 12, 2021 at 11:21:18PM -0700, Vipin Sharma wrote:
> On Tue, Apr 13, 2021 at 12:30:50PM +0800, kernel test robot wrote:
> > smatch warnings:
> > kernel/cgroup/misc.c:61 valid_type() warn: unsigned 'type' is never less than zero.
> > kernel/cgroup/misc.c:210 misc_cg_max_show() warn: we never enter this loop
> > kernel/cgroup/misc.c:257 misc_cg_max_write() warn: we never enter this loop
> > kernel/cgroup/misc.c:299 misc_cg_current_show() warn: we never enter this loop
> > kernel/cgroup/misc.c:323 misc_cg_capacity_show() warn: we never enter this loop
> > kernel/cgroup/misc.c:376 misc_cg_alloc() warn: we never enter this loop
> > kernel/cgroup/misc.c:376 misc_cg_alloc() warn: unsigned 'i' is never less than zero.
> > kernel/cgroup/misc.c:376 misc_cg_alloc() warn: unsigned 'i' is never less than zero.
> > 
> 
> Tejun,
> 
> Should this be ignored because MISC_CG_RES_TYPES is 0 as no resource is
> defined but the code has 'for' loops and condition checks which are valid?
> 
> If there is a way to fix these let me know, I will make the change.

Can't think of a pretty way to slience this, so ignoring sounds good to me
for now. Maybe smatch folks have better ideas?

Thanks.

-- 
tejun
