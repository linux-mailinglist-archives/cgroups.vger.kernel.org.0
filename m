Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B00977C46B
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 02:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjHOAab (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 20:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjHOAaP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 20:30:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5558C1985
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 17:30:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686be3cbea0so3979679b3a.0
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 17:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692059412; x=1692664212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkGNWYSgRV4909uG6OYXpkPdXlVdi8nXfegqc4fz99o=;
        b=SnlqSEdp6FwjyYK0/JgNgCFOe0+OyYkJxcVB71brWYFhDqH1zKvIVtEozJnPdxAb9J
         tVDVEeCLy0xicy6Ft/jB+WceTPL1ieHuR4FCyw+778HUSlzbfyeH6y0bDnvi3QSSfn3G
         d4Kxosrkb3+1XejznEeh+eNCyV+042Cxyqo5ChrGaigrxU8tizQw46IAvr3RgAzDdsju
         N4frI+gHFVf0H0Cpfz4WmiLeCZc4x7HXImzuZ+1nEKCeepboFMqpyfZBQy1fZnlavlfY
         Gi7dqvZpfai6ubCCEh//IiRlNAU0XIC+uO5oOKasdetSpPgfuDf0wrUGDP4cTS/v2KRV
         L4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692059412; x=1692664212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkGNWYSgRV4909uG6OYXpkPdXlVdi8nXfegqc4fz99o=;
        b=U1vpAsPpgHPTP2ek6lOb1hIFQtln/geuhjLHWPMfa5YJKO9e8zm1/UH6XN3s79FMmx
         Omf4dWTcYbebafGpTX9I6pXYlJJN4KRnUgXa9X8+SeCUQpD65P6x5kp8m0VIaHITm5eu
         iUsGBsoocSFCLEVON1O/al+b+4is4WIqgerdsBgCeKQiwHsNLTlIB0UHVN8anAclblC7
         6hnFwH9BKe15UJd3/cE/9DFtqUa4463epCrdusW0/zPxVM0up2yDBtvAJ2vaOa7HLAxb
         TdYtvTB5Odz/9n6hhtiycrPPXJxgePZiJbH7gPP/s9GOHs6gQ0KxxXBm3rpsZabcNoL/
         RwKg==
X-Gm-Message-State: AOJu0YyGTnNLjn5p5SGCjBr4UJ5l9Dj7wYkC21vOe3qRSOEg8QDLt5rm
        AbJhTWE/rWx4Dbjp+5KMZGU=
X-Google-Smtp-Source: AGHT+IFVDtnLJGJJQtiNTg39xysw7nuBvt+46xdITD5z/BFAwh1m8z1VEF+gHENaIqe1dSNY0gR/8A==
X-Received: by 2002:a05:6a20:440a:b0:13a:3bd6:2530 with SMTP id ce10-20020a056a20440a00b0013a3bd62530mr717534pzb.1.1692059411195;
        Mon, 14 Aug 2023 17:30:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id s21-20020a639255000000b00564ca424f79sm9180909pgn.48.2023.08.14.17.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 17:30:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Aug 2023 14:30:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Aditya Kali <adityakali@google.com>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup:namespace: Remove unused cgroup_namespaces_init()
Message-ID: <ZNrHEab_635Z68Pl@slm.duckdns.org>
References: <20230810112528.838797-1-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810112528.838797-1-lujialin4@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 10, 2023 at 11:25:28AM +0000, Lu Jialin wrote:
> cgroup_namspace_init() just return 0. Therefore, there is no need to
> call it during start_kernel. Just remove it.
> 
> Fixes: a79a908fd2b0 ("cgroup: introduce cgroup namespaces")
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
