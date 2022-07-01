Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D7A5627FC
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 03:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiGABJp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jun 2022 21:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGABJo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Jun 2022 21:09:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E1B599E7;
        Thu, 30 Jun 2022 18:09:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o18so927497plg.2;
        Thu, 30 Jun 2022 18:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ygHT2jAw914f43IVltgvjT9GLQcCfN55KKGJRNI/BxE=;
        b=TCbSrA2CBbCo9r/tWWtCU9TspHb5SREc2B0ylUhPwlb2whHLQfZFQzJi65Z+vfWSbd
         uP2dWtdU3KgH+GVGXOSsufjmUvdD/CJNe+3EYzSboinSUektABBkXvJSdsCgGT20YU8+
         /Ynz+i5I93xJUPaVJwlt0gN21yvCKCPf/rOr7C8TBfdxzRLoYG9ThANACmZ7cBNE9Wha
         OyJM9vDGT+FDZOcejtNfzZtlyEsfRsSdwNxn3gAwmGoM0YPxIc/eqkUhHyCZeaVJiZiz
         8AKXVAsicGkNEF5XMjb8Lw81j9YpQH6mA/pQQQYurQ1VI+TfBB92M0uLtCvqQvybytzr
         hRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ygHT2jAw914f43IVltgvjT9GLQcCfN55KKGJRNI/BxE=;
        b=UezIONrFFpnsOxpr4v/t7/+QpmsBJw+Zj5TxhB1kHWITbowjQgRAHDrHFxuWYJ+Ft+
         ZRFAC+HQNH5Ga0afyG724R+IDPbv7PFwmKdj56A5OxnEgjYFWjrlqItBACkhcidehGV/
         ftDh0jsfg+vShf4HAZESW6gptTyXfVCaJjKsJ6PcHq4GW3nNvX2+hB3Kn9nsI/rIcfY4
         UXNjnFt9bNyyPh752gVUTCUGk5/XH/fjuFCYVttgApVWyYL7UMSxtkqJmbVyJeZcYrKz
         FBqDI6rjmnVtw7qMP1kXyGNkynkBS7xGNhcMfQsrxhn59rnurK+hqfmQ1KuMTUpYoP3U
         YrEQ==
X-Gm-Message-State: AJIora/UKchaifISSadQAflvRrUhYCvE9QwtECHuqZg4e4QdsTL4kYfZ
        WNDcVWE0+djDEyCyDlPxyKe97aKCF9ZQeA==
X-Google-Smtp-Source: AGRyM1uyMm/xC2AAvG7JSDusG2mttPqtTbBPGHurL1wklNY/ixZQWHF9kfJMQP5wI/wPHO26Yuo6wA==
X-Received: by 2002:a17:902:cec9:b0:16a:416c:3d27 with SMTP id d9-20020a170902cec900b0016a416c3d27mr18407818plg.107.1656637783113;
        Thu, 30 Jun 2022 18:09:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4f4a])
        by smtp.gmail.com with ESMTPSA id y17-20020a1709027c9100b0016648412514sm14107965pll.188.2022.06.30.18.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 18:09:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 1 Jul 2022 10:09:40 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Lin Feng <linf@wangsu.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup-v1: use find granularity format identifiers to
 make /proc/cgroups show pretty
Message-ID: <Yr5JVHhSUCrbT8OH@mtj.duckdns.org>
References: <20220630082539.83602-1-linf@wangsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630082539.83602-1-linf@wangsu.com>
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

On Thu, Jun 30, 2022 at 04:25:39PM +0800, Lin Feng wrote:
> The listing subsys info is unaligned with the header columns and we can
> make the output more intuitive to read by specifying "left alignment"
> and "fixed length" format styles for seq_printf.

This has been proposed before but the file is useful only in cgroup1
which is in maintenance mode and the format has been like that since
forever. Given that there's some chance that it can break dumb
parsers, the choice has been to leave it alone. It's such a dumb file
format to begin with and just leaving it to wither and die seems to be
the right direction.

Thanks.

-- 
tejun
