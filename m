Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCCD74DF2C
	for <lists+cgroups@lfdr.de>; Mon, 10 Jul 2023 22:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjGJUZ0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 16:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGJUZZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 16:25:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7062313E;
        Mon, 10 Jul 2023 13:25:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8ad356f03so31686525ad.1;
        Mon, 10 Jul 2023 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689020723; x=1691612723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUELfvlg4gHGwdGYe8YxWDx5h185SGtFxuTpLn1TdkI=;
        b=s3s8DqVP/I2FnyZ3aJrDYkuPF989n9Zuc82IwqVsWDs07HIWbqnO10HdkwYkeBRvV0
         uJSsrC7vkOnM2jz/q7KFV3j4MpxSIZpL23FWotrmEN21IMK8PB8Iz+TehPKkwdrQ+/VN
         PGD7VVUg/QfdXtSnwNC+zZrZNhzPkygySADBXL5cbQcRU2bp8hrEG1Afc+9B3E4eoDBd
         XmTtNHY4yiXJ7+uEr93gHmFamSrTQpFz9lWx8FLihNYvuBNrAyXU6/Xz6cy6aild6aqS
         DmebHhe3LiLMs1r2slNhlouZOvrQB1D6E9wnsM9rlSe/UvQ0mdsJzk5nm3y7VKQubXgL
         r9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689020723; x=1691612723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUELfvlg4gHGwdGYe8YxWDx5h185SGtFxuTpLn1TdkI=;
        b=DYOC9XobgAcqYpr7Bteg4aANizsDn32s2ousTmmsACkwKLvjNC4Fifhl8Fj4nR3+XV
         ZK5EPPKeVYm/uAPE1P+rAM/k3kuskVqoR3f7cd7TQfgN5Xb1VSHLY2IS4dSpOttswhvU
         uCv+QZLj7fEoY96+y2K14D9EduOrNUF34BUhD5p1AHPW9xm83ZBlNsAZ9Ew4SlUTLknO
         lIKoF8eWEMXnKw5VPJUm0DIE1Rw6lIBeDFCxBLFbzkaZTa8HzifTukmQI522Hezka2pl
         9+m7vCs8KV5aCRLY7xbW+c+uKqdzlRnPwsLm066qv60ELGZhA0cv4vxq4Lcs0n0WGVEV
         ukNw==
X-Gm-Message-State: ABy/qLal7vrSu2In4WWlXhoonBJLrLkAm9kddwhf7Pl2BBOgy/U5azVv
        32tGLN7GflUqAnYTxnTic8s=
X-Google-Smtp-Source: APBJJlG7YJk1oXEAddvknVua6SNp07hogLzFPD1xUk6+DzjCcN9f1hoZ0MIsHp2fjilMYbXkMSuPYw==
X-Received: by 2002:a17:903:22c9:b0:1b8:9b90:e2bc with SMTP id y9-20020a17090322c900b001b89b90e2bcmr12367065plg.52.1689020722703;
        Mon, 10 Jul 2023 13:25:22 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b001b8b3108292sm315830plg.12.2023.07.10.13.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:25:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 10:25:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     longman@redhat.com, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: simplify the percpu kthreads check in
 update_tasks_cpumask()
Message-ID: <ZKxpMRwNpnNTmYN5@slm.duckdns.org>
References: <20230704113049.1019118-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704113049.1019118-1-linmiaohe@huawei.com>
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

On Tue, Jul 04, 2023 at 07:30:49PM +0800, Miaohe Lin wrote:
> kthread_is_per_cpu() can be called directly without checking whether
> PF_KTHREAD is set in task->flags. So remove PF_KTHREAD check to make
> code more concise.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
