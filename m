Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C47959CF51
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 05:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbiHWDW6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 23:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiHWDW5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 23:22:57 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C3E4E603
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 20:22:56 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c2so11681695plo.3
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 20:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=bNUjpvmBAwk/P6cxUtt2FxYhiH7UbJpC/KjVw1DvQyI=;
        b=B7f2yea+67/amPKu9MkN+JDwqA7oNEV79q8FkfFvZ0xqT50fhXDcyeSXhgTlWBgy6w
         9L4N/tzPn0fpr2+Kx7w49c/7NcH5ODp/W3ikw69fE5L1NqOLb+ud07nMnkppJqRJmMH2
         rfuPCeEwa+8hQSBi6SA8NPyLNwZyugqOpEV1gk/EM5Hmgnlv3yj9oKA1H1T3PpMoScX+
         ShAqm7m5uyQvgxz4B/dSPKNMx+maxPVijuQ3v+wIz8AL6opDzVy4u+LrkyJT+x42klPA
         hWTCpak7q8y8Yo9PmvX9mazXRV4qwqYnh5ORzGo900NeIG2AVcNAvKMeW8go0OAAnRSo
         T5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=bNUjpvmBAwk/P6cxUtt2FxYhiH7UbJpC/KjVw1DvQyI=;
        b=t8ZR2DDThOO6AxzgPY9wVmJwN8fJ12n1CqfkyeHb+gX2TYUgetBdLgstBK4BQOLekg
         wA+xC4r9rChC+EZ8FtldNtBq3+dNZRJXgCcxeQDL86N3OkZzb7WzrMzo+/6/+69J2ION
         +ODxFM/j8KUoAWDzX6sWpT4xlWoz2cJ7f98aq6/NukDhIwojN6OSS27c58MpbqLYdbdZ
         4Ua6qylbMSYilMFuNXiQj+MnZkayCbd2sUtIcd/1mjkzfwgY2EPyHxMZN1HWYi+2iQPb
         ZV/1aLmujnzvVKxDjTX1KX4DeUKWoPDwulGURAYaR4FiussxAVKoC5FYgT6ZtZUfxZjt
         bktg==
X-Gm-Message-State: ACgBeo1vCnJNslFcNTvFNk6xqNIxI0Dx1QqK6HdQNtJXKWHZapnXgC9G
        TMDW7TPOCI/oPT1162UmmeU=
X-Google-Smtp-Source: AA6agR7nqs9IG78dxMEZojNys8CtotzvEee3wNtQHEbGVahAu+CAno4zfBhecFldg5SKz8KQk2W4lQ==
X-Received: by 2002:a17:90a:e7d0:b0:1f6:a38b:e0be with SMTP id kb16-20020a17090ae7d000b001f6a38be0bemr1330427pjb.100.1661224975354;
        Mon, 22 Aug 2022 20:22:55 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:2dc2])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b0016ecc7d5297sm2267765plt.292.2022.08.22.20.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 20:22:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 22 Aug 2022 17:22:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chris Frey <cdfrey@foursquare.net>
Cc:     cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: an argument for keeping oom_control in cgroups v2
Message-ID: <YwRIDTmZJflhKP2n@slm.duckdns.org>
References: <20220822120402.GA20333@foursquare.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822120402.GA20333@foursquare.net>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(cc'ing memcg folks for visiblity)

On Mon, Aug 22, 2022 at 08:04:02AM -0400, Chris Frey wrote:
> In cgroups v1 we had:
> 
> 	memory.soft_limit_in_bytes
> 	memory.limit_in_bytes
> 	memory.memsw.limit_in_bytes
> 	memory.oom_control
> 
> Using these features, we could achieve:
> 
> 	- cause programs that were memory hungry to suffer performance, but
> 	  not stop (soft limit)
> 
> 	- cause programs to swap before the system actually ran out of memory
> 	  (limit)
> 
> 	- cause programs to be OOM-killed if they used too much swap
> 	  (memsw.limit...)
> 
> 	- cause programs to halt instead of get killed (oom_control)
> 
> That last feature is something I haven't seen duplicated in the settings
> for cgroups v2.  In terms of handling a truly non-malicious memory hungry
> program, it is a feature that has no equal, because the user may require
> time to free up memory elsewhere before allocating more to the program,
> and he may not want the performance degredation, nor the loss of work,
> that comes from the other options.
> 
> Is there a reason why it wasn't included in v2?  Is there hope that it will
> come back?

memcg folks will have better answers but the short answer is that the kernel
really doesn't like giving control of a task stuck with an arbitrary
backtrace to userspace, and that kernel OOM detection often is way too late,
so cgroup2 instead goes for enabling userspace-drive OOM detection and
handling through PSI. The following doc has some information on it.

 https://facebookmicrosites.github.io/resctl-demo-website/docs/demo_docs/res_protection/oomd-daemon

FYI, systemd already has its own oomd implementation in systemd-oomd.

Thanks.

-- 
tejun
