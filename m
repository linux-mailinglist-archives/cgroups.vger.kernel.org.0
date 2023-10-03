Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478637B6EEE
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 18:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjJCQsq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240501AbjJCQso (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 12:48:44 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04403B0
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 09:48:37 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-49040dc5cedso506166e0c.3
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696351716; x=1696956516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7fQqegtPGr2l/qfGLLeKHAsEgJgKMskDcYWjAE5QgNs=;
        b=gVKov6mPeAcopJtqLwZsXvaTj9WR0vDK2+KkquuE/SjYdRn1jSZzwvo3S2upYQ3YXP
         fF7RnI3OWo63osg1t7KQ2L2EibfLTAQEs+NgBCiIM/MAk4FYyjsxGxSmo0aAkOBxf/3K
         NrGgY0UunZZNfEyVcE0wFUZTMjs/ldNGMRf2EZGgJVr9FvMrhEl+ceE1eNyCQYRUVG/v
         tnSqY6ElKdByFadA9Y2iHAr3p2Hgl2ZwzjzlvaA3LIURF7mKZgTN5O+iTNFtW/EmWbla
         dixOHshXditOZwGRzylht4pMObof4vwtsyaIHqYh1TDurtciDJak9FG+l+WisyxvPbXZ
         D8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696351716; x=1696956516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fQqegtPGr2l/qfGLLeKHAsEgJgKMskDcYWjAE5QgNs=;
        b=YfouPVsFyBjjiFLj3RhmUWrRo3E+d9wyHUb/SVcCwopJuYCbf2jfOEk9lRcs8PVWtm
         LIAk2wCHhKJ8jwfI+T/bv/N2m8LER9slTff/dme1q5L08zDp+rGN5xCibLqnXbPMfPvV
         5xi2tTpwCpgUfGEW4sAJy11YSp4y7rfHvzYnQzB0IZZbXQaD4/S5p6uCwXj/uaYwFJBY
         onCgTn/Yq1yYFcz4u8+2bKWrWn2udRK39TcdMR3FYVQHcLYdV8bkYLo1Fc7zHvTT2r+k
         ZMkwRLtrW8NhS211/SF4UAEC5inewQMeyAyAlRx2uvoYtaJaYDlnsNrdJUCllEQOh+RX
         X14w==
X-Gm-Message-State: AOJu0Yw/jwJ1HPHlxct1fuPD4rZ8ipEV5JrDX6bXCJlWaIB62nc2NhcY
        YPgqPbDYEl4sMJR5bkQSFli6FA==
X-Google-Smtp-Source: AGHT+IEzXIwhhXIHlbSduWagnxX4PLiRp03xXdD5h2lcmYMEvKP7eJDYYCtQTx7mB+AMKvyGeBlo6Q==
X-Received: by 2002:a1f:e043:0:b0:490:b58e:75a9 with SMTP id x64-20020a1fe043000000b00490b58e75a9mr10316947vkg.4.1696351716094;
        Tue, 03 Oct 2023 09:48:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:753d])
        by smtp.gmail.com with ESMTPSA id g12-20020ac8480c000000b00415268abe26sm570941qtq.8.2023.10.03.09.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:48:35 -0700 (PDT)
Date:   Tue, 3 Oct 2023 12:48:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 1/5] mm: kmem: optimize get_obj_cgroup_from_current()
Message-ID: <20231003164835.GA20979@cmpxchg.org>
References: <20230929180056.1122002-1-roman.gushchin@linux.dev>
 <20230929180056.1122002-2-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929180056.1122002-2-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 29, 2023 at 11:00:51AM -0700, Roman Gushchin wrote:
> Manually inline memcg_kmem_bypass() and active_memcg() to speed up
> get_obj_cgroup_from_current() by avoiding duplicate in_task() checks
> and active_memcg() readings.
> 
> Also add a likely() macro to __get_obj_cgroup_from_memcg():
> obj_cgroup_tryget() should succeed at almost all times except a very
> unlikely race with the memcg deletion path.
> 
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
