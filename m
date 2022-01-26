Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F2649CFFF
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 17:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbiAZQuA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 11:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiAZQt7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 11:49:59 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D402AC06161C;
        Wed, 26 Jan 2022 08:49:58 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id i1so76137pla.9;
        Wed, 26 Jan 2022 08:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qHKkyLNz3BcJqhVoJVmJSW+AQ6LC+YMbazKnt8TVUkM=;
        b=EqkmYvUuHqLMrlellKgtt5dH4fjRwBxeLQlg4yOHiXrlRPwkZmEvL5zjR9gsWSQj8e
         FH/FdYO/EASM4JiRC2XMNbbtLLaauL4WXuAHKZc0or3hXKBCPHdtOFGpP+luU0nhVRhw
         ISVG1N4X6ctoZfEnl3UB1LEwNQISpF5UBMCga4EdNsAAxwXm9gMzD+tjcICd2bG9L0sA
         Fj66vuOp0rx9m6DVJ724BgsVjrxTHV+lVjBnWgTXX25kBbEXt0zAvwtvq72HmheS7iva
         z/wkmZSUkSjfDI6IaTzK9NHM1ChbYGdI5oqObJRJF0ttryPec4a4MTIJ2NWrucNChbJy
         ugzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qHKkyLNz3BcJqhVoJVmJSW+AQ6LC+YMbazKnt8TVUkM=;
        b=f7GTLWjv+Srzi1anyoPz10f10nNa3Ta8dj7g8xza/eYzqFf6VVeDw8Gvb5bymqp3aJ
         R3RLTJADqz42SDaxfFiwe6fU0ZILDwDqEMA8CD6mg5Rc8QaF52uFED39Nr7DFXk8/EiP
         aoqZcQqSdkQZFeu1+eZqqXAA7Nc+uYzcqKx7HjoNumdJcPO/LOenGvahw6RVhtwFa89M
         AeD2iIymRYx1QlVFMymWsXYNX1pbY6NbNUXqqu+037+K/gdSoMDlVEArcHJ0RrGP2el9
         hGn9TfG2eOHKJGhF2tLxCKaawzy++zUa0UwPKRLryqaKPgfzD+xX14PxuBBBGysorreg
         ePfg==
X-Gm-Message-State: AOAM533prErK+CLzqhPKtdkiDu84eoa9p2pw3cYNzjCZs4nRpUkqqEHR
        vSyo1ZTyB9pP24dOnwxU6g+DJQWTVV0aGg==
X-Google-Smtp-Source: ABdhPJxSvfAEkqpVTTNNS1c3bwoVCUdq52Tj7PktJnSjmA7duMqtB66nxR0YUt1iwK8wbpp2259SJg==
X-Received: by 2002:a17:902:7603:b0:148:daa7:ed7e with SMTP id k3-20020a170902760300b00148daa7ed7emr23330196pll.150.1643215798273;
        Wed, 26 Jan 2022 08:49:58 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id o7sm2441165pfk.184.2022.01.26.08.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:49:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 26 Jan 2022 06:49:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: Fix the bug that subpart_cpus updated wrongly in
 update_cpumask()
Message-ID: <YfF7tPxxNT2SxWxl@slm.duckdns.org>
References: <20220118100518.2381118-1-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118100518.2381118-1-dtcccc@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 18, 2022 at 06:05:18PM +0800, Tianchen Ding wrote:
> subparts_cpus should be limited as a subset of cpus_allowed, but it is
> updated wrongly by using cpumask_andnot(). Use cpumask_and() instead to
> fix it.
> 
> Fixes: ee8dde0cd2ce ("cpuset: Add new v2 cpuset.sched.partition flag")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>

Applied to cgroup/for-5.17-fixes.

Thanks.

-- 
tejun
