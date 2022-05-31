Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9564539562
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 19:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346509AbiEaRWl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 May 2022 13:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243694AbiEaRWj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 May 2022 13:22:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D53690CDB;
        Tue, 31 May 2022 10:22:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u2so2872678pfc.2;
        Tue, 31 May 2022 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9PHjFs0sIqj5lWkWsEGrk3cMVyvsTEeIL+bMtOtQI8g=;
        b=OBgz4OH07SYHRH6i23pXY3sWr1cgmBDmYWyyjFcfiUuhnPmpDeeb2eN9o2IHsnITBz
         V9SNk8FW9410NeGJYcONzvZjmXcODw60CjZo9oJFy09hjtKcQKrrG55qdu0nXK/t3m0A
         FITf826d/mlqQmC9tVBZzzMU9TgRmiBlzmZp8CdGUftW2jj3C7HSWBQdFOMeaX/kdbd+
         mhK+WUW4hhuHqvysNs+J/lr01kTV5IPSMSEispnTynIofVHsFumoYmX+MUC1CFDAFEVo
         X/gF0pBGpAAYb0CXt7NfL56W/1E890doIHdDr92hZoZKimXBIlUnxDN4C45iYSbLfpcy
         UddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9PHjFs0sIqj5lWkWsEGrk3cMVyvsTEeIL+bMtOtQI8g=;
        b=s6dLwo7QUo1JDmq+WmwKznlhl4HdBusuxetQr4vmRKVi8SUCtP/sF7vcUWlu1QMdL0
         G59RrrdIFnpex1CeiwpgXtqeVRDQKZeuzbNIeC3h9e+d6odUE6oVCT4/WdplFhPV74JT
         +8KIT0YVa7h7E+pJO+GeU1xjuIrDE5Pb/oaxitodVjboZnyTTSgco+aMB9IW4OPKiMPb
         4h3mQU1/kOhbLdBPlWYAAMo5la5OBg3czkBHToZF3UIcTUtrfkkMJvJ6Em1lvdbM2Xtw
         cD1TTeajPGo5M1lYjHV8911otPcNdGsJPBafAuHIsV9qlusKJA/vY0lxlLOx9YD4rQKS
         Ygow==
X-Gm-Message-State: AOAM530mHpZHhPPfwIKlULtIvhhnaFNpw8Jc9EtnHCHEXH6ZnDUNJgK8
        6/wpw8p9B7/R9vjtbEr/DLc=
X-Google-Smtp-Source: ABdhPJy8CTe0X5aYugHEww8yoE3jzJBjHdP7iLgM86cDqAyT1yKKnQTlJLhVA65KJUJDz4YoMQ9d5g==
X-Received: by 2002:a63:202:0:b0:3f2:75a7:cd28 with SMTP id 2-20020a630202000000b003f275a7cd28mr53414415pgc.537.1654017757983;
        Tue, 31 May 2022 10:22:37 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:987b])
        by smtp.gmail.com with ESMTPSA id oj17-20020a17090b4d9100b001e2608203d4sm2400455pjb.5.2022.05.31.10.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:22:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 31 May 2022 07:22:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: wait for css offline when rmdir
Message-ID: <YpZO26mJ3Wm0AeHo@slm.duckdns.org>
References: <1653619158-27607-1-git-send-email-zhanghongchen@loongson.cn>
 <YpCQZ5RRnxwh7fmK@slm.duckdns.org>
 <e74e03f1-cb54-b158-a085-2965fd088d1d@loongson.cn>
 <YpVo4XiIDu68w40Z@slm.duckdns.org>
 <fbb820c5-dbcb-0f00-c365-d3c57ca27edf@loongson.cn>
 <YpZOIz/CbQs+aWF6@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpZOIz/CbQs+aWF6@slm.duckdns.org>
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

On Tue, May 31, 2022 at 07:19:31AM -1000, Tejun Heo wrote:
> Maybe just keep the sequence numbers for started and completed offline
> operations and wait for completed# to reach the started# on memcg alloc
> failure and retry? Note that we can get live locked, so have to remember the
> sequence number to wait for at the beginning. Or, even simpler, maybe it'd
> be enough to just do synchronize_rcu() and then wait for the offline wait
> once and retry.

Also, given that it's an memcg ID issue. It probably makes sense to
implement it on the memcg side.

Thanks.

-- 
tejun
