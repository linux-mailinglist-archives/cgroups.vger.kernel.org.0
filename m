Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7178F65F1A0
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 18:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjAERAq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 12:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjAERAh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 12:00:37 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C33754DAA;
        Thu,  5 Jan 2023 09:00:37 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d15so39939047pls.6;
        Thu, 05 Jan 2023 09:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWuNYcgMRUdXt3lrKpOOAhpTNHvmJnhLtWA6WFPkqzw=;
        b=Ip639JaYOV1aW93fhR9fwRH10jtovSU7bc+87GLEpQ+7rAxYP89lDQrJAJsr2FX6W4
         aI4VpoefbHI4W7mUgseXFMeB3elqfgJAmZIvaMFo5/s6Z0OjDK3eHaWaHAmCn0uFnX6t
         kOHaQWZWvNX8ogHf+qeBkzT3vQbBpAo48dSLguLwXtrFfBJXmtjwkHNqJUhPzdXc6PkS
         BDkw7vuxKXEyvEu4F9Bk2v+2c9TDA3TXClOaIDNfSxIYjOkAwt6/suSKu1swOAB2Ut44
         rhTI0gv4n6qsAGEuBQGHyBx0fZFcj9lXGw6KBaKYwIypB0W5q90hjWTlQKrYwgVG5yUy
         JbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWuNYcgMRUdXt3lrKpOOAhpTNHvmJnhLtWA6WFPkqzw=;
        b=TAxQWxHlVfoOXJz22YiBaCVYN5qXikQAt+XDMMYkIhY/1dwueouziYYRK0x2Q5MUjz
         HMgaYEWZAa29YFa1RvdPREukV4RYQZLfw+MHX0cd/RAYWQdPZtnGncMn3ruuqdnI0DGw
         C8QNVNbgEfhAoT8p6AWBl+CJLhJa520Zkb26q+ovJqP6Th+mCmdT/YDsrkiJGqtH2NdR
         kljw9sv3q6icY0BpQWnvscN1KY8oAkAQOUySXyDFSbWiLzw14qUv1aGu1FDOvd1siOvA
         B8fV+yqRbt8Vp/bCLS2WpNvUYtQ6o/8sVsKcOEhQ0SHf1GlXAZEY276Cy2ZVE8dC9yZH
         8DHQ==
X-Gm-Message-State: AFqh2krxoqiVhl4JxsxIDaU4/aYBkQg8hp4NzxaceQ0aq7ZAHaKWsqT3
        17w5v7tMMqkWJzJdV/kE1eA=
X-Google-Smtp-Source: AMrXdXt4uRQVRgPNn+82sQpY7HLkRbMOO20I+dRTWJJ/bfU20RYAkQ2J+eEF8mhTo+v0yZuvmxdXlA==
X-Received: by 2002:a05:6a20:9591:b0:ad:7428:d326 with SMTP id iu17-20020a056a20959100b000ad7428d326mr70011472pzb.30.1672938036598;
        Thu, 05 Jan 2023 09:00:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k201-20020a6284d2000000b005822ce3b2acsm10560119pfd.115.2023.01.05.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:00:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 Jan 2023 07:00:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] blk-cgroup: fix missing pd_online_fn() while activating
 policy
Message-ID: <Y7cCM60kalx+MnYu@slm.duckdns.org>
References: <20230103112833.2013432-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103112833.2013432-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 03, 2023 at 07:28:33PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> If the policy defines pd_online_fn(), it should be called after
> pd_init_fn(), like blkg_create().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

However, it'd be useful to note the practical implication of the bug in the
patch description, which seems like not much as discussed in the thread.

Thanks.

-- 
tejun
