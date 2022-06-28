Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1478255D818
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiF1JXG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jun 2022 05:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344236AbiF1JWi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jun 2022 05:22:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591611D314;
        Tue, 28 Jun 2022 02:22:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n10so10587417plp.0;
        Tue, 28 Jun 2022 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/RPscv3+8g8rx4jXo23oMEeXPiuNo7BXGYwm+0AjXxs=;
        b=To1tuJ6ezfSPRvfvYleOSb9lKKOhueWfZvhziXTEgCM9PUQE9mQ/xhT/GQKDwAx3+K
         VCwO+26BUmVeT7tjCm709OpoNluVA5TQnQMiEBOnZWK6u0h7/2MQKkzXLs/QTBPtLd+t
         uaEv/5/AD3aMBX+7rY78FIuqtsaMYfGOxtLmBiFL7mE3st9gwwEYdkaho0GnDCcCS+C6
         4iEp8WxQDcPWTMDrt/QPMRtV+Nsnq3jb5UHhTTcpJedWllF567kplSbpUcwnVLjnZnAa
         /5C8nTucMrmiuELtf9puqfjdHfigFReLoMkmJ6zo4PcDCEvdsypTDDGCHRq1camco5J+
         ++lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=/RPscv3+8g8rx4jXo23oMEeXPiuNo7BXGYwm+0AjXxs=;
        b=u82EjJlCCIcvKHmEVtCSWd6+mXAy1iqPxgQKMvYluUpYtFi6PmtvolOQkWCxY0vAI/
         YLUBlP6gIc7FhqO0M2PvcG5v9I/YgpjXtLbXOqXwgnVLyq6cBbzB0/9uZTpR+Mgnpdew
         zE3fu/dshLAm9jjiXIFIB5RvpFhgFGP8btvfa5jjIRxlZ+FhFSyGtpcFL1Nn0RHYIU8o
         hOpMWqyKfPxXsaHQt0oUnIA2D7p6+Kr2kJZOSzvk8/yReIsJuWaenPf/kMJbGFq4Duc+
         pGn3IQBNgeFWg06r9jBvEPhNlLwu/jT42or8Oy1tpYrpR8M77HmuTlf8QYSB5AfVHm1v
         ZVsA==
X-Gm-Message-State: AJIora/RqHoZziuODpDtdhb1mxlvzz0+/MGni9AIjxSRm3i0vIJR5nBV
        ffN1UlIVP5BEM/ErWQxRBxU=
X-Google-Smtp-Source: AGRyM1uO4shhe2Mc2XBAl9CUgG5Vgh4gk8x1TLLyeTMM88uYJk5piLi8VUIAziOH8v19ngumbUBM/A==
X-Received: by 2002:a17:90b:1e0e:b0:1ec:b2a6:c9d0 with SMTP id pg14-20020a17090b1e0e00b001ecb2a6c9d0mr26659992pjb.230.1656408156659;
        Tue, 28 Jun 2022 02:22:36 -0700 (PDT)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709026b8900b0016372486febsm8688757plk.297.2022.06.28.02.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:22:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 28 Jun 2022 18:22:33 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Vasily Averin <vvs@openvz.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH cgroup] cgroup: set the correct return code if hierarchy
 limits are reached
Message-ID: <YrrIWe/nn5hoVyu9@mtj.duckdns.org>
References: <186d5b5b-a082-3814-9963-bf57dfe08511@openvz.org>
 <d8a9e9c6-856e-1502-95ac-abf9700ff568@openvz.org>
 <YrpO9CUDt8hpUprr@castle>
 <17916824-ba97-68ba-8166-9402d5f4440c@openvz.org>
 <20220628091648.GA12249@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628091648.GA12249@blackbody.suse.cz>
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

On Tue, Jun 28, 2022 at 11:16:48AM +0200, Michal Koutný wrote:
> The mkdir(2) manpage doesn't list EAGAIN at all. ENOSPC makes better
> sense here. (And I suspect the dependency on this particular value won't
> be very wide spread.)

Given how we use these system calls as triggers for random kernel
operations, I don't think adhering to posix standard is necessary or
possible. Using an error code which isn't listed in the man page isn't
particularly high in the list of discrepancies.

Again, I'm not against changing it but I'd like to see better
rationales. On one side, we have "it's been this way for a long time
and there's nothing particularly broken about it". I'm not sure the
arguments we have for the other side is strong enough yet.

Thanks.

-- 
tejun
