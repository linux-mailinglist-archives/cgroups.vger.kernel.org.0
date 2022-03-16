Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33FD4DB72D
	for <lists+cgroups@lfdr.de>; Wed, 16 Mar 2022 18:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345195AbiCPRdv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Mar 2022 13:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiCPRdu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Mar 2022 13:33:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7585B3FD
        for <cgroups@vger.kernel.org>; Wed, 16 Mar 2022 10:32:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fs4-20020a17090af28400b001bf5624c0aaso3167094pjb.0
        for <cgroups@vger.kernel.org>; Wed, 16 Mar 2022 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gPiP2TEj1iJh+74qfIuMhil4PD7R84NUaohWqsH6kSA=;
        b=i0C6IyVxhui172CDcTzYtyC8+1jj4hUP1Z7WUT42kUCKeZ0sdQKeUgP2kAKqMqdDnY
         Zt9SOENS6uK7ACzOJyyXX0HxwyNOrXx2bdI0rsWLy+ae0f/dwhIax2fDr64Uljrx9WK6
         SAC26tzU6ppoXy7OvzA4SzdgE2hPUWKu3keayE5D6XG84/AFZiZ6svjQkUFNT3LKLce4
         4f4IJ+066LXeXk6wY+r36MMP0//Q9lZxbJVdl9W3PCcB8K2B50m0PeTiApom3wDonDrq
         j0CCxYELS7/d5VoefJuULsI7vCeHYTHiJCat8fw5kK/W4z2VArB2+kDqF+q0aZAsp2xm
         y7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gPiP2TEj1iJh+74qfIuMhil4PD7R84NUaohWqsH6kSA=;
        b=TGVZM2cI18blIsmxcrzV5GZ71TDvAjaFDZAKvD1b7Gh05fpw36VJKP8BqfUfKFntJG
         RCkUH+FoS8Uzg1b7ZiEPfSme7KFBEXckJItlW6C4yWEbb6ttv/cLUMmoxlbEfxDU4ahd
         BwnFKD17eZEcveQilMUjFl8O3scgcuD9Eapf/bUqw8MBKH3QjvAWZMphe+SjzTmVBOOb
         DfT/efzdFgAPFVGGk8VzfxCqVA0ufmlY+eiq1ucNQkm6JFwlz0VzJD0OtB92JHAatZYC
         CWb/EtUKrlUL+HtcGzPlDDtXLkPwQHRDL3DgZOiTJwPcRJqj20G5hPYoo0bAQN+3ZSV4
         vBvQ==
X-Gm-Message-State: AOAM530JIq6Et5EhDxAfcViwnqsksQUHGS/nYgP+zqtj0H/YfdCU0HZo
        W58zQpMrkpJebRijEUE2sPwEDH0YRk9iWw==
X-Google-Smtp-Source: ABdhPJwZHUZ5RAA2hX/IsIcJO8hc3hyo0hDUVKWNomgCXxloBtBwJL5M/eb1nUrW0JbUZyp50GXKmQ==
X-Received: by 2002:a17:90b:4a50:b0:1c3:dfac:88f0 with SMTP id lb16-20020a17090b4a5000b001c3dfac88f0mr11356640pjb.128.1647451955013;
        Wed, 16 Mar 2022 10:32:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id pc13-20020a17090b3b8d00b001c62a846311sm7866316pjb.6.2022.03.16.10.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 10:32:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Mar 2022 07:32:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Olsson John <john.olsson@saabgroup.com>
Cc:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Split process across multiple schedulers?
Message-ID: <YjIfMLG5W2a/E4vX@slm.duckdns.org>
References: <b5039be462e8492085b6638df2a761ca@saabgroup.com>
 <YjIShE3mwRyNbO53@slm.duckdns.org>
 <e9cac4aba6384c5c91125a9f7d61a4e8@saabgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9cac4aba6384c5c91125a9f7d61a4e8@saabgroup.com>
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

Hello,

On Wed, Mar 16, 2022 at 04:49:29PM +0000, Olsson John wrote:
> By using cgroup you can delegate the authority to configure a subset
> of the hierarchy via rwx and user, group, others. By using the
> per-task interface you have to be root, right?

Yeah, deligation can be useful. However, given that the configuration would
need some automation / scripting anyway, it shouldn't be too difficult to
work around.

> Also, we want to separate the configuration of the threads from the
> application as it need to be deployed in different hardware scenarios.

The thing is, to put different threads of a process into different cgroups,
one has to know which threads are doing what, which is the same knowledge
needed to configure per-thread attributes.

> And we need to be able to easily replicate a configuration from one
> machine to another machine.

Again, I'm not sure how needing to put different threads into different
cgroups is much different.

> We also need to configure other aspects that cgroup allows us to do
> for the set of processes.

This one, I agree. There are controller features which aren't available
through regular thread interface such as bandwidth throttling.

> Since cgroup solves all of the above problems for us, why using
> something else? :)

Yeah, mostly curious from cgroup design POV. It'd be nice to support use
cases like this well but we likely don't wanna twist anything for it.

Thanks.

-- 
tejun
