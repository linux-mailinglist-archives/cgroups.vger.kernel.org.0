Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5E05833AC
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 21:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiG0Td2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 15:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiG0Td1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 15:33:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F48E3AE52;
        Wed, 27 Jul 2022 12:33:27 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e132so16694312pgc.5;
        Wed, 27 Jul 2022 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=84;0;0cto:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:from:date:sender:from:to:cc;
        bh=6pnTblxCyJMu4c6E/4UqG0qh2Y7YbnKnimTleXn2d64=;
        b=JrjKtZg0AWloTpMMF1BWDJo8qbcS/l1KoteqVQntHR87K9jNSXqRl1tmDCq7pgkQ7Y
         W5UoJsZ8ypj+r8vmNk7aXOoh1fPNs5umdWf4mdKl7PqRFbzlxlEIb2S4HIjaYZCxMA+z
         g7/9MYr9YNJP1OFIYZb8qpI34w15h3v8rA5QtBfEu57mL+J0uLkAxz0sYTzfhFVQ08Q+
         9E8G3lgnEEzxX+r1ZNlVg1h90WP3uVjsM7oQeNCm1MWCpKjDc0nTLcY/dsMgZV6JBtIt
         8LzxiF7pv6ihLoNey3IiHkBANXEL7CSaQ9fHIFxA8f/qt2F9Nbg9jh/jQGTP1f8zYVOP
         5nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=84;0;0cto:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:from:date:sender:x-gm-message-state:from:to
         :cc;
        bh=6pnTblxCyJMu4c6E/4UqG0qh2Y7YbnKnimTleXn2d64=;
        b=R+cBWGTWIgOsGSyeihO+a5Tf/X0HhE3p3773GU9K7r3oYw0Qsf75mBt1dzTwmZtqCH
         O4hiblPjdsSwsgP7pkCa4gPQe65a6pmwFWOE41KvlorJ9SEYErfMNDTh9TnWXNKHAI7w
         mJiAVfWJ1fDWLcLd8sPTzr2P3H9J+RsawzMemxreExtbXMq4Xr4PunAsDyHrqlkp0pJo
         +HFpHDCelkf4VnVuqO3Ijh1xLj8ZoSOH2zQ5mLLpWyVeBNa2vZcBVswAoirMCPa+sdPu
         3ZnZIPJO6yvyI77FUvK+qJRkxKadx+XMlDAmhSv/PM0wvLcPgVHEZapH0uJA6hTaD46A
         FzSw==
X-Gm-Message-State: AJIora+Y0m2/afbh1w2nJqKSqXmHpaxdinyTXFJ+ZLGAQcb4HwRHMcJJ
        lQUrynPWumPeZ/LJBYcoQ5s=
X-Google-Smtp-Source: AGRyM1uRC/uKhHvXoAjn4IxP2UWh2xu80qLkDbo6u7WMC0tNhq1YZdk1xDSPH8ZWrtfzcJtJgdTtdg==
X-Received: by 2002:a65:6714:0:b0:41a:49fa:2bd7 with SMTP id u20-20020a656714000000b0041a49fa2bd7mr20062879pgf.331.1658950406370;
        Wed, 27 Jul 2022 12:33:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5a55])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b0016d01c133e1sm6961575plk.248.2022.07.27.12.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 12:33:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jul 2022 09:33:24 -1000
From:   Tejun Heo <tj@kernel.org>
Cc:     Imran Khan <imran.f.khan@oracle.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, tglx@linutronix.de, steven.price@arm.com,
        peterz@infradead.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Query regarding deadlock involving cgroup_threadgroup_rwsem and
 cpu_hotplug_lock
Message-ID: <YuGTBLkFerUboctl@slm.duckdns.org>
References: <8245b710-8acb-d8e6-7045-99a5f71dad4e@oracle.com>
 <26d0e4cc-be0e-2c12-6174-dfbb1edb1ed6@oracle.com>
 <bbc01477-231b-3dbb-3e09-9338f5413f06@oracle.com>
 <ba48eac5-8ef7-251b-11fe-8163bb7a2d54@quicinc.com>
 <224b19f3-912d-b858-7af4-185b8e55bc66@quicinc.com>
 <YthDz4BnfYHce1od@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YthDz4BnfYHce1od@slm.duckdns.org>
84;0;0cTo: Mukesh Ojha <quic_mojha@quicinc.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 20, 2022 at 08:05:03AM -1000, Tejun Heo wrote:
> On Wed, Jul 20, 2022 at 05:31:51PM +0530, Mukesh Ojha wrote:
> > Looks like these patches are the fixes.
> > 
> > https://lore.kernel.org/all/YtDvN0wJ6CKaEPN8@slm.duckdns.org/#r
> > 
> > Would let Tejun confirm this .
> 
> Yeah, looks like the same issue. I'll write up a patch later this week /
> early next unless someone beats me to it.

https://lore.kernel.org/lkml/20220705123705.764-1-xuewen.yan@unisoc.com/ is
the thread with the same issue. Let's follow up there.

Thanks.

-- 
tejun
