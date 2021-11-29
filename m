Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FFA46278F
	for <lists+cgroups@lfdr.de>; Tue, 30 Nov 2021 00:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhK2XHt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 18:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbhK2XHB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 18:07:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8A3C111CE8;
        Mon, 29 Nov 2021 09:39:51 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso14883047pjb.2;
        Mon, 29 Nov 2021 09:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jXtNF/sPL2y+FUYzBp0rUX3UsbHP3l0DZcj0VSipxzQ=;
        b=Ja64lXFdxwDLTwzcCX7CVYDIpHTlZxNqc0Fa6bm28nUCevMarEHl0xIPFIx8/H8NUV
         D6NCwIn8E8TV6liXLFYmB4hDBK+HIz/lThf6bZVJvocJ6J8syTB/g5X05Cy3eJ9NaB7C
         y+0wNiXp0x+DIlrvBdRkEkoHGRIU/0Dm4uEoEqcz4r0bl5SL7dMtug4+HlZrwpnfTWG+
         b4Q3Wnge5QIK3/lfxSIvRUWuJv8am15+opOEPf2Nvv+FpbXzfqW5csZiK4GwB7vE/MFm
         yQ27hpi+zg0inn1ldPqVacjNX9vRBj02UV6zz//ORkQLpARoEcY7eJNKPhvuF/3ZkFpA
         Oq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jXtNF/sPL2y+FUYzBp0rUX3UsbHP3l0DZcj0VSipxzQ=;
        b=qijwwUirGg6hVpthCvcDTlI1K0OmrFbjarSSwx+SxvAzRdta/2FkkVcW18voo7t5vp
         vl2ovR4/Mk75IzL9AnZg/9onfkbtv/DEKeb5SSlBwK0LWT+TXcmB2AlwfOs9LaCn1yDZ
         cgDU6QVQ1AmVZrWgoed2SWBkEBzuVn3d78EtTYROYAV6a2Dq/qg48NGpE2S1Cc/z/Zuo
         269CEkZhXtE3gJrVDSOLeUo2kDrAd6od0ovP4kYhXIBrf9abUzhWw/ycxijWbfl3jgrR
         a8PrhUzMA00TmGPDYmn/d5j797f4p3sAvMVIOoi0ETWcXH7rVPCeRnjz/1o4NIVpKVkM
         6X3A==
X-Gm-Message-State: AOAM532jdutxZaGBLQgfUGOKcjfsa3wLvQcU3IuQ0obictRuBqvynla8
        Agam/nrc+vE9cGhkhHH63roW4UZZyea8hQ==
X-Google-Smtp-Source: ABdhPJzd+h973yGq3DVl8eJnnV9BbvEFLAN0O4J92uD5Ql1r9Jj3DYZ1Z+UzjCjdGXiUaNMRFVNu4Q==
X-Received: by 2002:a17:90a:3045:: with SMTP id q5mr40478485pjl.58.1638207591089;
        Mon, 29 Nov 2021 09:39:51 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id p16sm19000913pfh.97.2021.11.29.09.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 09:39:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 29 Nov 2021 07:39:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup: get the wrong css for css_alloc() during
 cgroup_init_subsys()
Message-ID: <YaUQZZbFDDOpwHYY@slm.duckdns.org>
References: <20211127145919.31159-1-richard.weiyang@gmail.com>
 <20211127145919.31159-2-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127145919.31159-2-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Nov 27, 2021 at 02:59:19PM +0000, Wei Yang wrote:
> css_alloc() needs the parent css, while cgroup_css() gets current
> cgropu's css. So we are getting the wrong css during
> cgroup_init_subsys().
> 
> Fortunately, cgrp_dfl_root.cgrp's css is not set yet, so the value we
> pass to css_alloc() doesn't harm to the system.
> 
> Let's pass NULL directly during init, since we know there is no parent
> yet.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Applied to cgroup/for-5.17 w/ minor description adjustment.

Thanks.

-- 
tejun
