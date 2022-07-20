Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCFF57BD5C
	for <lists+cgroups@lfdr.de>; Wed, 20 Jul 2022 20:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiGTSFL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Jul 2022 14:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbiGTSFJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Jul 2022 14:05:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D4B33;
        Wed, 20 Jul 2022 11:05:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l14-20020a17090a72ce00b001f20ed3c55dso3016381pjk.5;
        Wed, 20 Jul 2022 11:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YWTDneNY8P5vWW2QTCkwFAjSMu7YWo8lKAMC6oCSaaQ=;
        b=oOtz9PsBinTflz88HKUTWrJh15Cle1xn8l7q18DcwWR4RAQQoC1u4AiUoWdbGWqesa
         62bNh9C6BftUhOKODBoCr/KkXyz9BeZkLIw7iOlBiHkRUzEkts542clfCFazWIHo4cq0
         eDo8cdN3gyi3x8DSn8uwPy8crW/bairzY9qvpP1bGcHdIRL3aZDrk1yg6qvDA0Fj3JXp
         d+kdlb5JmQ5RnOGq+xgkxrpa3j8vmneroyZgjaE1LRiW+aaunRjbo4eu6y4pcpz/qLkD
         KzylACtgOLbHjyysmtuUB5LfKCwwCQRhvLzvpaL/68Yzm7dnzisw3BClyDoYi0lcYzLa
         MPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YWTDneNY8P5vWW2QTCkwFAjSMu7YWo8lKAMC6oCSaaQ=;
        b=3nkKKYJVnmM4K7eS9oHBWT55CQe5RtIWN0Vpjx53K6TvLma59pSU8W+jvtygkn1KVT
         bqai3ORJRd8k0auX/VjYE66vqbODswUoZBE1kSyiPNLxVs0NkHQRHy+pmvOc/s/j3/82
         iVQbeHWdtACHIQw4PAf001+b58S31GRsqrLC/h8MJJ78IkmbzsaMY6Y1mtAXOVIAVTMM
         LgeHwXw+JW+36B/4zthG5Cvl6cA0kqjjcUCuhRmGhJgn1t3F75f/cxjP85tW10w/uM0W
         e8FlgkR1hltQ3IhbZ26BnRZeWGrHhd+ZareevDvlVXp7AbqKsvsqbKHZMODap+P5/EPh
         TOJQ==
X-Gm-Message-State: AJIora8BgsDAH8CfmTTNJQWR5iEk9iDL4VJkCY238x9EymZy3R3QyTvu
        uXSafFPfKwA8RZcqHBfr6GI=
X-Google-Smtp-Source: AGRyM1v0TtSLkkoduTln9t8wmKX8ivsSt4WboCxqUEcsf7Y5mUAxn1qBKJsKxBef83qntl3xCijY7A==
X-Received: by 2002:a17:90b:2243:b0:1f0:b0a:e40c with SMTP id hk3-20020a17090b224300b001f00b0ae40cmr7053364pjb.76.1658340305346;
        Wed, 20 Jul 2022 11:05:05 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f3dd])
        by smtp.gmail.com with ESMTPSA id r18-20020a632b12000000b00415d873b7a2sm12030959pgr.11.2022.07.20.11.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:05:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 20 Jul 2022 08:05:03 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Imran Khan <imran.f.khan@oracle.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, tglx@linutronix.de, steven.price@arm.com,
        peterz@infradead.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Query regarding deadlock involving cgroup_threadgroup_rwsem and
 cpu_hotplug_lock
Message-ID: <YthDz4BnfYHce1od@slm.duckdns.org>
References: <8245b710-8acb-d8e6-7045-99a5f71dad4e@oracle.com>
 <26d0e4cc-be0e-2c12-6174-dfbb1edb1ed6@oracle.com>
 <bbc01477-231b-3dbb-3e09-9338f5413f06@oracle.com>
 <ba48eac5-8ef7-251b-11fe-8163bb7a2d54@quicinc.com>
 <224b19f3-912d-b858-7af4-185b8e55bc66@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <224b19f3-912d-b858-7af4-185b8e55bc66@quicinc.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 20, 2022 at 05:31:51PM +0530, Mukesh Ojha wrote:
> Looks like these patches are the fixes.
> 
> https://lore.kernel.org/all/YtDvN0wJ6CKaEPN8@slm.duckdns.org/#r
> 
> Would let Tejun confirm this .

Yeah, looks like the same issue. I'll write up a patch later this week /
early next unless someone beats me to it.

Thanks.

-- 
tejun
