Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7982636994
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 20:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbiKWTH5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 14:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbiKWTHh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 14:07:37 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CAEF7;
        Wed, 23 Nov 2022 11:07:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id mv18so8978404pjb.0;
        Wed, 23 Nov 2022 11:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJ1XxPBP6l91zCvLonYfrAhVHQ+WkP/p/oLP73T5QzE=;
        b=AYyIeS27Ml0qFv4GlN+J2HpoE/+ez5mP3DcQSSSmQVPSkehPvX45k2Pm/f0poKKmAn
         JkEzBXH/AItqzO4I/wVi8+WjPCIkFphvfmjws+xNBp7QlMPlGPBYAWh08Vn15kzcumFC
         VvGXi0KmtdQKUGtxC1Qtb2eE87cCKKOIRz7ZEWWLdWKCae7goewehyPTWXahQMp87mQX
         O0EEpF3Rok7izhkHeTtFsyuZEPnOD3QNCZuuqLVSqhkc8HQ51kp30LJfyTtsu5E8vUCc
         atJfeK2l/4ayUmLyTxU1Xrw3a6CTqA+S58Btpu0n+Xlx3NwKuq6bTFCBvLGNBBUqki+a
         5+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJ1XxPBP6l91zCvLonYfrAhVHQ+WkP/p/oLP73T5QzE=;
        b=2DeyQBIJWNOvzS+p/lTpvEpaHhzXUN7lFmF5/bxebGetR9o1VlYa/bRm5t475q7M2u
         DQwy5glOtLl+jCPvZa7AnudxXbHjtgIgLDE3MS2N1YNMhC5HyrxP8e5eb4EKvvLv04/f
         NPeBd6/FC/yZVhGoK4U3iXSYykcOXYkrG209wxv13O9bQHgBsRaWFZvfWKudL9fMZhVR
         06JWCntxY+9QN+FVs3BLHnHRyf9NW6JAoFidAQZl3Y/PJwD13Eflo6o8g1FuuGidLNdW
         N4K3xU6q3MZwoiEQB8icpnNZiMVTuzPIL4Sd6iO84D7Qf/7qsvyMgMZgfZIvBX+kCMvI
         zAjQ==
X-Gm-Message-State: ANoB5pkG0BoCRr9HlBArprSaKd3jEgpRP65Ch8jkZZu4AA9xhHhbJqHk
        WDZLnd6Kay0mnP28EyoADos=
X-Google-Smtp-Source: AA0mqf4Fj8ByyNPocjylBuHLzMUXUMD2uMQBOrd9yJyAeW0b+ZHxcqQa4vgSjoR8k2up47m36FbRPA==
X-Received: by 2002:a17:902:e80f:b0:188:f571:cea2 with SMTP id u15-20020a170902e80f00b00188f571cea2mr13284658plg.146.1669230454912;
        Wed, 23 Nov 2022 11:07:34 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b00176acd80f69sm14609625pli.102.2022.11.23.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:07:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 09:07:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     "haifeng.xu" <haifeng.xu@shopee.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Optimize update_tasks_nodemask()
Message-ID: <Y35vdbcVYx99zePI@slm.duckdns.org>
References: <20221123082157.71326-1-haifeng.xu@shopee.com>
 <Y35Swdpq+rJe+Tu3@slm.duckdns.org>
 <5fccf438-fdbe-1bc8-6460-b3911cc51566@redhat.com>
 <Y35sbREgYE6aIdIp@slm.duckdns.org>
 <a89de82d-41e7-a40f-a5a3-83ad62bf383f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a89de82d-41e7-a40f-a5a3-83ad62bf383f@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 02:05:59PM -0500, Waiman Long wrote:
> Right, the group leader is just a marker to make it easier to avoid
> duplicating the work for the same mm. If the group leader happens to be in
> another cpuset, it will suffer some performance consequence.

Yeah, I guess that's gonna be good enough for most cases.

Thanks.

-- 
tejun
