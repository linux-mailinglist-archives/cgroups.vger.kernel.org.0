Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E91A76D7ED
	for <lists+cgroups@lfdr.de>; Wed,  2 Aug 2023 21:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjHBThb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Aug 2023 15:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHBTha (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Aug 2023 15:37:30 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC251722
        for <cgroups@vger.kernel.org>; Wed,  2 Aug 2023 12:37:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bb893e6365so1723785ad.2
        for <cgroups@vger.kernel.org>; Wed, 02 Aug 2023 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691005047; x=1691609847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISzIgGhTLcZdgPj3UkOAFHUdMQQ45Q4Ef86Im/scO/I=;
        b=piacTQspru1LaGeL+sb6/aBbUFMAImUJ0qdSJvQ3bYNPK5Nktiy3VArW4b1TD2xl0M
         2AMkphtlcAppMzUuG4qJLhRx/pbw1f+XIqb5wb4bEL07WeXrHQWbfyjyR16yUYi+HDZR
         U5M5DHJUNBHtVTWOcc4tENIHSjT6W9MLPTDtJqycV0OfV/txQcegxA6S1Gpa9Rxl4kbg
         alhFQSdR8ZM+Y6A1sWGSYnd64CdCS1jLX4+A+OrTsO2TohbNnJIiUUWfEC1nTCzaXq5H
         NeHY5bTpSq/+ZCn4uQeNok3ahoz5C3pyiAh258+BL5pbPkQwhuI05F6fuBxtmMB9vsac
         23Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691005047; x=1691609847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISzIgGhTLcZdgPj3UkOAFHUdMQQ45Q4Ef86Im/scO/I=;
        b=PMAOhZ9ChJcr2tPWkN0Km8yWjcJ1Jg4Eu8zBO9Tz2p9QfE1+QHQDD9Citm1GrLQobO
         n8zGCdZTZgv9HXo3cgU2MOycSjG3q57isnyBaZ327Bda6NeFHFKgmIRjdn/x3Zk8K/mJ
         aAY8g8n4Y+Ls3+GzkJ56TGnI0pr5yBM57vEjO6kUXBHJ4MejCSc59YD40jhBLJwIATui
         Hn0MMW3tlT6TciTaxsR9YcciCsgac46sxt9GFzMLjWl76ZzUTYO01Uv82hw9iZy07o4D
         +i3F4COHBqxojeIdmTHYtogZcEpAY77YjZK4AhYsBAAkIyOBN5Q3erRhjhABQCMsfJxo
         AI6g==
X-Gm-Message-State: ABy/qLY/mOmPsGrWU5f7KvGcwUaa3gg4NULQGyt/LVEEu0cq3dEph9FX
        O1xpMl+rEK+Mm9/Xc7LemP8=
X-Google-Smtp-Source: APBJJlFOKRXDqgQAHJULzVK5YF87TmsMilnXRE71lDIUU4xjcMa6Gt32O605jNVFZ8akcXyyVi5yzA==
X-Received: by 2002:a17:902:e751:b0:1b6:6b90:7c2f with SMTP id p17-20020a170902e75100b001b66b907c2fmr20211358plf.55.1691005046807;
        Wed, 02 Aug 2023 12:37:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902b70700b001bb28b9a40dsm12796122pls.11.2023.08.02.12.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:37:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Aug 2023 09:37:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Cai Xinchen <caixinchen1@huawei.com>
Cc:     longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/cpuset: fix kernel-doc
Message-ID: <ZMqwdM4mfj6pOUyq@slm.duckdns.org>
References: <20230802030412.173344-1-caixinchen1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802030412.173344-1-caixinchen1@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 02, 2023 at 03:04:12AM +0000, Cai Xinchen wrote:
> Add kernel-doc of param @rotor to fix warnings:
> 
> kernel/cgroup/cpuset.c:4162: warning: Function parameter or member
> 'rotor' not described in 'cpuset_spread_node'
> kernel/cgroup/cpuset.c:3771: warning: Function parameter or member
> 'work' not described in 'cpuset_hotplug_workfn'
> 
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
