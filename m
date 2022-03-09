Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B8A4D2551
	for <lists+cgroups@lfdr.de>; Wed,  9 Mar 2022 02:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiCIBHH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Mar 2022 20:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiCIBHC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Mar 2022 20:07:02 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446C9CEA38
        for <cgroups@vger.kernel.org>; Tue,  8 Mar 2022 16:46:23 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y12so856134edt.9
        for <cgroups@vger.kernel.org>; Tue, 08 Mar 2022 16:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3TVdSxpJSiaP4MOwCEb1srbEqP/8itZ5hxFbBSfspVU=;
        b=qfG26zXTlnlLytofDQdjhzVQFVrHlWWJuLEGQbiURbJCyxVT+S/+sCyW4UBw1Tkhr6
         8eI5+5BNaRRo9y4XsorMbX4YHDvCFOnXhpgFVbT9DW60svIIJ/2y6XS7v+wkm1WHOqKg
         WzrT9toQ0hjaXratMNqXPhUbZU9J1602zrv3d78qwPoxlaJfy2RnCJZ4g44NawRFR+ZE
         W4SP4j8s4u0bhDIpF207Pl2laylCjlqPTWxbyoIBw2chodz7bUNsDHAKIVYqEkyA5Rtk
         8Gjh+K1W9qjsBHWp08N13oASyPy8WxzX7E7jr6w3VtPML8CukBoR23hrUXehb/WyQz6D
         GaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3TVdSxpJSiaP4MOwCEb1srbEqP/8itZ5hxFbBSfspVU=;
        b=pjzbNHvaaX8ht7ihUHz7SlnN+etHJPQmCoYEz9Ea8Wowvfh0DL/nczX5g/w1/kt++Z
         rCmrLhqyRp4l0CTfdbUTB5a2/wlVkY/QB0uSYgHoKHO3+vBJNlpRzZ97Q5vANmi9mdp5
         g7NRt39hJfvWm/991xfr0trXl//nE2mJ1Exx1HnevBEwgkjpUA5/bIPZG6qolnQzoNcQ
         hLrWimZknY02uI4soOj2VrwmQmkTP/aVrAPggGjmg5tcZPizdkRrJOKWdcLN71D2rhah
         uCvFUl5d6jNAaklegV1cQFbjMSA4IMG2CyMiTNv5EiiYvaMdYY+4ExZY7u9u+c16TmOw
         5Q9g==
X-Gm-Message-State: AOAM530cpbv68tPbQh4ecz0gphuP6l47RCt00bTUt6gFN3jSJQj+jp7C
        j0gV3JYnpBvcew8KR7EQPfj3/ZB0EmI=
X-Google-Smtp-Source: ABdhPJwhqoTfTnqz2UHKQ7U01/8pOfHlb3I4XDhRgsrbxI50FYbyWqEeW4niU5JVgCkR8TQpCIvyeQ==
X-Received: by 2002:aa7:d403:0:b0:40f:739c:cbae with SMTP id z3-20020aa7d403000000b0040f739ccbaemr18848563edq.267.1646786781541;
        Tue, 08 Mar 2022 16:46:21 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id gl2-20020a170906e0c200b006a767d52373sm109465ejb.182.2022.03.08.16.46.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Mar 2022 16:46:21 -0800 (PST)
Date:   Wed, 9 Mar 2022 00:46:20 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>, hannes@cmpxchg.org
Cc:     Wei Yang <richard.weiyang@gmail.com>, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm/memcg: add next_mz back if not reclaimed yet
Message-ID: <20220309004620.fgotfh4wsquscbfn@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220308012047.26638-1-richard.weiyang@gmail.com>
 <20220308012047.26638-3-richard.weiyang@gmail.com>
 <YicRNofU+L1cKIQp@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YicRNofU+L1cKIQp@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 08, 2022 at 09:17:58AM +0100, Michal Hocko wrote:
>On Tue 08-03-22 01:20:47, Wei Yang wrote:
>> next_mz is removed from rb_tree, let's add it back if no reclaim has
>> been tried.
>
>Could you elaborate more why we need/want this?
>

Per my understanding, we add back the right most node even reclaim makes no
progress, so it is reasonable to add back a node if we didn't get a chance to
do reclaim on it.

It looks like we forget to add it back to the tree. Maybe Johannes know some
background why we don't add it back? 

-- 
Wei Yang
Help you, Help me
