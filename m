Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47BE584502
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 19:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiG1R13 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 13:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiG1R12 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 13:27:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBCABF44;
        Thu, 28 Jul 2022 10:27:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x10so1669264plb.3;
        Thu, 28 Jul 2022 10:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=VbEpbcnRCKhYT7BZ0HSKVgFvbMAakayClnOZvBHVLDM=;
        b=i00rVjg3DaYMhQYt2uaTPpDZXUdlQ+KaCLpjoz3IEIhO1KJkqSkwWpy1/U7Uf/F/aD
         nmFgTkH1TiexdN5J0xFNoxsNwasPcbARyEDdluyAxzkqtOoUZni9gh2nJsVmmZVUf4Xt
         cV/aq3fSAIIAqz8k9rp+jo+k1XdHNaYlqrx0nfsdz0stk4DaDTrhBl4iyUw7qpidmOac
         GGvOSFwVaZrE6LDxLSV1yebcuuUAeZ3zPpMZWUBNFispkFDqlVx2Rk5aLw7LNWPr+Tw7
         ldPZYan//l8svd7n01XrDz4bRjQrKC3gazwQ+N+G9xjNJxI+R0+fooIua330gEkmXpku
         6JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=VbEpbcnRCKhYT7BZ0HSKVgFvbMAakayClnOZvBHVLDM=;
        b=YnsCkskJY6Q5ebe6ZSvcmHnQMwriBaQ+jnMKwm+BEp9S90a0anBmTsnHePxanFAK6A
         mayuBBCLRAzNBgU1SveLqaIG+P7n/unFD+bXj9Z/kpESOX9iEgZMkhDBS/XPls+dpIz+
         EeZ7MIm0guE+YELKT0Ib8VWNEN2Dgprm3Z0Y9R/QHSYlG5Y6sytLQnh0AUY0lwAJYdVI
         NVU3tcyW9/HUMiTA03ypNwrgfhBoJ0aN8nxCB5rr2xGtoykq3f1o1stpZpakiQoOO8x/
         y9HKll6k6qynWjh3HT/IDTRSahR1A4bNXabaNQbIsLsASMR7tI9BSzZmbRg7d7xbJTyP
         xbxw==
X-Gm-Message-State: AJIora9nqhHEqt+oODMkXzH8nk2IGOYljrdEjRl3djZKTnHkzmJGThDU
        y6kvt7yP6ph4myQn1q8z0KI=
X-Google-Smtp-Source: AGRyM1u5+4hMr4oZu9issv6Q/ERTdCcJGxEq3gDZsmq0mWG7JasQl8j1W+FQA8t4s9nHhjTnafpYvw==
X-Received: by 2002:a17:902:bd8a:b0:16c:dfcf:38ba with SMTP id q10-20020a170902bd8a00b0016cdfcf38bamr26699504pls.35.1659029247629;
        Thu, 28 Jul 2022 10:27:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902f64500b0016cd74e5f87sm1546605plg.240.2022.07.28.10.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:27:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 28 Jul 2022 07:27:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup: Skip subtree root in
 cgroup_update_dfl_csses()
Message-ID: <YuLG/RzJASE/8uTV@slm.duckdns.org>
References: <20220728005815.1715522-1-longman@redhat.com>
 <20220728005815.1715522-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728005815.1715522-2-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 27, 2022 at 08:58:15PM -0400, Waiman Long wrote:
> The cgroup_update_dfl_csses() function updates css associations when a
> cgroup's subtree_control file is modified. Any changes made to a cgroup's
> subtree_control file, however, will only affect its descendants but not
> the cgroup itself. So there is no point in migrating csses associated
> with that cgroup. We can skip them instead.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-5.20.

Thanks.

-- 
tejun
