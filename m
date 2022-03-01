Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D14C910F
	for <lists+cgroups@lfdr.de>; Tue,  1 Mar 2022 18:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiCARCo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Mar 2022 12:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiCARCo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Mar 2022 12:02:44 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF011A2E
        for <cgroups@vger.kernel.org>; Tue,  1 Mar 2022 09:02:02 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 8so17143680qvf.2
        for <cgroups@vger.kernel.org>; Tue, 01 Mar 2022 09:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/YNxm/fT1wA6TvRS9qleTg179AoKUDQbNyeBLEv308Y=;
        b=Pk8emi8eXbpNcoPmgag6OikmEnmUWl9pfmiMWBo8hxZaRqUiMAlvItwaBMzs0+GGbT
         EAKIdEXDglJL6w3HRJHsShOUU3vG+wefz1TzEcaw6pk/FZ2dEiYzmr0kqIbu69k+q6+E
         9wg11Xi3zuJu/Fo4fGe1xYwPgKLqswXQE+o4B3EqpveROMC/LJITv/KpzisLFGy9uKdG
         OsGFFHDziCi436AySIa+XjrrOi3UlBho2WSeYfuVNLvEjH/HVpobbI18NbzZrC3+jqy+
         ThLSiUgz9J0dUO82C8Ndi641vp2xlBArmPzSS/uNz6ayUfjFwI6KZHNDmoE+7s6BbiFI
         g4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/YNxm/fT1wA6TvRS9qleTg179AoKUDQbNyeBLEv308Y=;
        b=24Lvilt/a5ch15F66dSzOSKNqQPrPo1yVtMzNrPGb2JN9ayvReEgygLkZTtfbziETx
         W/U8LGgHuVLWTqbNiNNumXBLSOwX5zjAEsclYiozyJNndm5+QKWqbDnYOWnJDsSSYGmg
         /vqvHqu5RlnsfoHWP0SeCpZULnwjpG3FQXJdzxYL2ESMaxWHn0gK1YB5b+Ioj4mdeATp
         WKutO+qhL5ba87q39xVY3oBVzSBdJfaLUjKtCYgj+bJ2h5Wn2XlS1DlTt95eJCNMy8Oi
         EEbECA04iupEqh/R2nftbbTY3+vCb9C8aNTsZBjM8j45jyHGU090H6NJqp65GZlfD8z9
         ePjw==
X-Gm-Message-State: AOAM530rsRn3u6O2ItFfbO+Yug84jIj4KegXHJd3mP5RrTtn2391f86p
        Ql+u3gcHZGKU309xFvmChHwt2w==
X-Google-Smtp-Source: ABdhPJyeZAKY+uez2oE88Qa3pAqSUAtD+BKnu6VN+tWop9PJKgFbX/h4Ho7mTaCC6jQ8OTpMFzL0jw==
X-Received: by 2002:a05:6214:2aa6:b0:432:9dd8:ccb0 with SMTP id js6-20020a0562142aa600b004329dd8ccb0mr17544059qvb.53.1646154122053;
        Tue, 01 Mar 2022 09:02:02 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id w8-20020ae9e508000000b0064905055a5esm6731838qkf.92.2022.03.01.09.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 09:02:01 -0800 (PST)
Date:   Tue, 1 Mar 2022 12:02:01 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as a memcg co-maintainer as well
Message-ID: <Yh5RiUMegXf92ivM@cmpxchg.org>
References: <20220224060148.4092228-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224060148.4092228-1-shakeelb@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 23, 2022 at 10:01:48PM -0800, Shakeel Butt wrote:
> I have been contributing and reviewing to the memcg codebase for last
> couple of years. So, making it official.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>

It's already been sent to Linux, but for the record

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
