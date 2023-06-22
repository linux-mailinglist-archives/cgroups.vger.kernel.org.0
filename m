Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966E673A896
	for <lists+cgroups@lfdr.de>; Thu, 22 Jun 2023 20:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjFVSuL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Jun 2023 14:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjFVSuK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Jun 2023 14:50:10 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06294195;
        Thu, 22 Jun 2023 11:50:09 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-77e2c42de06so263563539f.1;
        Thu, 22 Jun 2023 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687459808; x=1690051808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YoqKoCGD22r5x5TeJTnO4aO3qshyt7k/108oz2dWFVM=;
        b=ef2yQscTpwf7n4KiHLRh6c4s+xIN4XgQISZYvu2mQatB000a88NnB9WtUyBRWKPgH5
         c8THlyujQvlhIgyFS5E02s/8dAJAn53nKF8WzM3RRfWUwgOOWx7W6z/7xhpf91FGK+Ta
         XyHGBZgJLiI2mfbgZKWvCX3Pm15BFlFVt5g/3ZSSAMNkCKvAZXakiZsrQadnGcdqW41r
         qG4UwFmhNRbA8nr0WnnMJSUI/VYTT6vYgUNEfHdpn4h93do8VMIiu7RwX6tKSxVwrPJf
         9FzzE0TU6R7CeqT7qzz9owIVNV2lYb6e8usC575oTy1812Oki1QKCHe/XgoltAPHfl/4
         TD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687459808; x=1690051808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoqKoCGD22r5x5TeJTnO4aO3qshyt7k/108oz2dWFVM=;
        b=M9EA3Zloi7ahCa67APenPblUHxntw8HszDomhdjNCNATZ8WfuC6QpPj4A8NVJ9gP0T
         kReZq0ASRm/yudtGMeoc/CSiXWUrkEAxQ01LvhIn80nBNrspKSMS+60t+QdLl4lN9H5W
         YDq6p3OBEYpmIDmEnRI5ZzYPYfMs6CppMhGKnb2mAbq9gfCwR75KO3tO0dcsX0O2TuGt
         H/neL46PIcydx/tS2iAYqhsTtIqFMeLFJHi8zqQQF1UeVi7ixoMw1DGTt1hr4SU0NcHi
         slVmkSnUh/K0WtUOmRea3rpA05VGdsVZRaFUMMzhkhuhys0V4hlK/oo0YP+Ahzk+s5Fz
         HXUg==
X-Gm-Message-State: AC+VfDyv6zOkdLArOm9z/JV/Y6G4Ycu9ff7sOW60imF7w7MNLHkd3ZGi
        dWKtfmx7qc6XknDhPpnbdZ8OMP2IAUV6HA==
X-Google-Smtp-Source: ACHHUZ67W8LShsgIAl8y0YsmIuLltL4MvdIcB2Y4QCWzzwBn42H5eRhINUmkS1S3dU6ByyZPnZezyg==
X-Received: by 2002:a05:6602:2184:b0:780:cc4a:d3 with SMTP id b4-20020a056602218400b00780cc4a00d3mr2983597iob.10.1687459808014;
        Thu, 22 Jun 2023 11:50:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:287f])
        by smtp.gmail.com with ESMTPSA id u12-20020a6be40c000000b0077e3acd5ea1sm2268718iog.53.2023.06.22.11.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 11:50:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 22 Jun 2023 08:50:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Steven Price <steven.price@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] cgroup: Avoid -Wstringop-overflow warnings
Message-ID: <ZJSX3bjnYTL0mCHj@slm.duckdns.org>
References: <ZIpm3pcs3iCP9UaR@work>
 <726aae97-755d-9806-11d4-2fb21aa93428@arm.com>
 <0d6377ef-bc34-784a-8694-478d0ade085e@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d6377ef-bc34-784a-8694-478d0ade085e@embeddedor.com>
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

On Thu, Jun 22, 2023 at 08:09:03AM -0600, Gustavo A. R. Silva wrote:
> > Reverting this commit on the head of linux-next gets the board working
> > again.
> 
> Thanks for reporting this issue. I'll take a look.

I'm reverting the commit from cgroup/for-6.5. Let's try again later.

Thanks.

-- 
tejun
