Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A0F74F9FA
	for <lists+cgroups@lfdr.de>; Tue, 11 Jul 2023 23:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGKVqd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jul 2023 17:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjGKVqc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jul 2023 17:46:32 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2516C10C7;
        Tue, 11 Jul 2023 14:46:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-668704a5b5bso5513880b3a.0;
        Tue, 11 Jul 2023 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689111990; x=1691703990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyzlh81U6Ju2jWhDiLjgeqy7+sksvV31PzhzVl8MBhQ=;
        b=aPy0SNz9dz6HANDuditq55E3EjWQCri+A9re2o5i05xDNLrJFWA3izghbC7A0uVoJX
         QXALQHOutvp97mrZej0leDFB9kp4fGa85LoQzCdj+tc3cLv8A4jq4qxl8mtrGA4KRm1I
         kZPJXtt6NQJLOZ+QnPOuM4vJLWnGnmOMb6SyFhJ+htPUt3j7eGUQAiCWFv/6KBkW3zqJ
         TSuapNB3+JMMaZ32q/jC9za6PUB4IoZEonxcNSv0qFTuFGXVfGDQGXDQjK/lapCVElIf
         NZN2Y0E5H6oI5UHwpiITD7sDl1DcXH9Ei8bQ2+2j3rs5OlXpTtdihDw6hMW1tCJ0l0KT
         00rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689111990; x=1691703990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyzlh81U6Ju2jWhDiLjgeqy7+sksvV31PzhzVl8MBhQ=;
        b=K+ysjPGEPhA+EDLn+z8pOcLTIdGDPwBxHw9SR8OlzKMDtFfRrcZ5NAfAPzdsQVYFXK
         4NFtZEfBlmMOLdAiM7NdBlkGqcXT0tYVbp+6/t5TqSWP2qQ0tKQSUmVJ4JA5A+PnrN/j
         +rxDjREc27UoyC8QK7L8VKoEiwTAiGjdRL0x4xOp1IRXrqD9N0vs6Qwgbb3s0YjboMXA
         fcTU6i+Ha0tj4tSyys9Vsv5qywRnUhCHRt+ZVDqozB9ASTlQfle8O+TFozNtLZ78ouyO
         NzyejtiGWmLWRMQIwh/OD2CAVlYYzauPqtoUSeIp9nHNmIq2tKumlJYqkk94T2vzXDHW
         CL2w==
X-Gm-Message-State: ABy/qLaVUfbGZ30AQ8GnHWOdEdb7211axm/SIhJrvIt1bk66ugw0wWme
        47/wHr+9t+qgnXsYuh3Pbhg=
X-Google-Smtp-Source: APBJJlFG4Jo/7savB2RiSA2npOJ/H7omJxLgnggtODSMG6vmeyq4mrXDj1WvnrDRCkWkBjeLA0iWcg==
X-Received: by 2002:a05:6a00:1704:b0:682:2fea:39f0 with SMTP id h4-20020a056a00170400b006822fea39f0mr19836512pfc.5.1689111990437;
        Tue, 11 Jul 2023 14:46:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9374])
        by smtp.gmail.com with ESMTPSA id e26-20020a62aa1a000000b0065438394fa4sm2223493pff.90.2023.07.11.14.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:46:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Jul 2023 11:46:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, sfr@canb.auug.org.au, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH] cgroup: put cgroup_tryget_css() inside
 CONFIG_CGROUP_SCHED
Message-ID: <ZK3NtKHk_w7XoAVZ@slm.duckdns.org>
References: <20230711023820.3854596-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711023820.3854596-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 11, 2023 at 10:38:20AM +0800, Miaohe Lin wrote:
> Put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED to fix the warning
> of 'cgroup_tryget_css' defined but not used [-Wunused-function] when
> CONFIG_CGROUP_SCHED is disabled.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
