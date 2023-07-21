Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393E975D119
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 20:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGUSKw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 14:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGUSKs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 14:10:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFF2E68;
        Fri, 21 Jul 2023 11:10:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-668709767b1so1581834b3a.2;
        Fri, 21 Jul 2023 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689963046; x=1690567846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45g6O9ZlJ9a46173hb9oD6WT0Gj5jDz2sDLA6BPWNec=;
        b=XU6YpFKPBbH37FVtZHEnptSRL3P3lrRfAIIxJ3QCDkfv56XTKiavtaE0iCqLTm1EAO
         /RmpapIvZqwgHjlnwe3v7/BAqJhlwdaC9UBDEdyP52asiRdv77jN/FbOHaJigcxI7+KX
         to4rHwtUxx4KimsHgPF+JAbDI2MWrQkRBcrgf/Dt77/xACrwezXxlq1sl0UFMsbq5iZl
         9OaS+4ukOVqSlVkZRCUsR24FH/hj14KVi2+45Xcchj9j/j89PstpJXLfX4JCTJ8zubAk
         f26L7HbfpDFFiUGvojF8dEyUzBdzM8/rbKgnjwX75YppW9YOGpfVrprimMo9Z5orXJ6F
         JC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689963046; x=1690567846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45g6O9ZlJ9a46173hb9oD6WT0Gj5jDz2sDLA6BPWNec=;
        b=YPzlsXB3uiGApqSyGTAkPO56bofn1dFpRdT6WQ7Qa23SGAfzO2gczLyjb4m9hvxJjl
         Vs+Tail0nremq7GnqfT3irrku9TeoYBFbg/14ILFTPyscD4YqqcXjUEybBghvm1+FC7v
         M/GL8b4Cr2LkyPBk9eiPZDGmvjDoNEmM/yj+BvWanNjHprDoD+GUKdbaZvnbZ/vqS6Rk
         ZmmDws8NLRgIKJHu1uVUoFAFkxPeq+pkgMpy7K0XEuOvL5xnX0s4sbGrB9dUIOQtwLcS
         AIqktf7E9MqSOHQOWSR4Xy60594KCYUT9l+SQBi06JT6O7Ju7nVeJYUPrlv5zqVGWflu
         FYNQ==
X-Gm-Message-State: ABy/qLbrKlb9wMpWa3p/fUorM1apPRtrax3uIV7hJQL70v5oXjdPB3FR
        kg59BvRXw9AEvQgK59RVYJ+IM7bQUqs=
X-Google-Smtp-Source: APBJJlGWL/QaHzT9fjxpbPhRKhL3PqU1vZDdIAooBipU5Zb/hmjVWDl8d+UIFe3PszzRVMXaB7E7OA==
X-Received: by 2002:a05:6a20:5483:b0:133:f5c1:57b7 with SMTP id i3-20020a056a20548300b00133f5c157b7mr2929218pzk.51.1689963046299;
        Fri, 21 Jul 2023 11:10:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709028c9200b001b866472e8dsm3771890plo.241.2023.07.21.11.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:10:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Jul 2023 08:10:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     cgroups@vger.kernel.org, dave.hansen@linux.intel.com,
        hannes@cmpxchg.org, jarkko@kernel.org, kai.huang@intel.com,
        kristen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, lizefan.x@bytedance.com,
        reinette.chatre@intel.com, vipinsh@google.com,
        zhiquan1.li@intel.com
Subject: Re: [PATCH] cgroup/misc: Store atomic64_t reads to u64
Message-ID: <ZLrKJAyea-U5Lsiy@slm.duckdns.org>
References: <ZLcXmvDKheCRYOjG@slm.duckdns.org>
 <20230721120231.13916-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721120231.13916-1-haitao.huang@linux.intel.com>
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

On Fri, Jul 21, 2023 at 05:02:31AM -0700, Haitao Huang wrote:
> Change 'new_usage' type to u64 so it can be compared with unsigned 'max'
> and 'capacity' properly even if the value crosses the signed boundary.
> 
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
