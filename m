Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FDE48BBFD
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 01:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbiALAqi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 19:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343866AbiALAqg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 19:46:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFC1C06173F;
        Tue, 11 Jan 2022 16:46:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u25so3309474edf.1;
        Tue, 11 Jan 2022 16:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YgB9W3ER2Fk3JAkU4HFtCEF3WoMMr2PxfP7Sgs5PJD0=;
        b=PtupSkCZRZdKSmNDUGbWNksFXWjrpfe+bp3K19mEv1Fmx2j4cSpPPJhKRWn1cgPohI
         PPkEfVVVPrGBsl3fBy6LbNz8AKw/Mn+7/2i/tgkPXnH0cFtdl5/yP+jvPTOHBZszTOHY
         rh0C8UnwkvrFlCP+tie4bR/5NETPf6dji+imcsAX6pg/Nhhy5NrdqAfKWj9cXt5eGvIt
         8rubtDI/vYYUHq3VFK+89ZQ2921Db/hBi+yzO5Lx43tLTR3K4R2lqaz45mrza6d+ULkJ
         zHZcYNP/tCuz8TpUTXtkQooCLA8m5eo2D9OyVsPJAKB5qKTpPN45InBPD/Tey+Wreqz/
         jeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YgB9W3ER2Fk3JAkU4HFtCEF3WoMMr2PxfP7Sgs5PJD0=;
        b=IdyZ+6YVe5iS3uNWb+epC4fbMI7/kNad7Risyreh8JKm7qN/s1/i0O/sXkmPkVxoME
         gykkelcgsl1oeGeld1iiIID5ySdnBrwg2PCXGiRbxcxBb1tnM1oLzwulUlr/YN+0a0Fm
         whIKw+8VDWyONWVrZIEJUTVXj46j2YuwJGQQ4/ZduPH65iaBSG3cRXgZvsnaaP+k7lvZ
         YxzIYwck30ztHk13dqWBOwM83k6z4J2tNifelfSLq71TG5AGRUe0CPZFjg/fXYgiUil3
         VWzPidmPB9qNkgwH8pPAvMMQyz4Pg//MdN04BljhERAI+IihOzUjkrTJNH2X8LoE8kmw
         8M5Q==
X-Gm-Message-State: AOAM532EP9ovht5WLowYiHyaM4gX4h+i42UKSytbbyoNtMV6GgyPmDnR
        5D4bTs5PKcGBl8lEHsPj86c=
X-Google-Smtp-Source: ABdhPJw5WGkyK3h0037r0/5+Z7FKq/sEb0axuzKUvRH1lKpbVEDd+P7tGOxDrvb/F3sUOUiYnQGcjA==
X-Received: by 2002:aa7:cc83:: with SMTP id p3mr6552182edt.382.1641948394816;
        Tue, 11 Jan 2022 16:46:34 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 1sm3999679ejo.192.2022.01.11.16.46.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jan 2022 16:46:34 -0800 (PST)
Date:   Wed, 12 Jan 2022 00:46:34 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, guro@fb.com, vbabka@suse.cz,
        willy@infradead.org, songmuchun@bytedance.com, shy828301@gmail.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm/memcg: use NUMA_NO_NODE to indicate allocation
 from unspecified node
Message-ID: <20220112004634.dc5suwei4ymyxaxg@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <Yd1CdJA5NelzoK1D@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd1CdJA5NelzoK1D@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 09:40:20AM +0100, Michal Hocko wrote:
>On Tue 11-01-22 01:02:59, Wei Yang wrote:
>> Instead of use "-1", let's use NUMA_NO_NODE for consistency.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>I am not really sure this is worth it. After the merge window I plan to
>post http://lkml.kernel.org/r/20211214100732.26335-1-mhocko@kernel.org.

Give me some time to understand it :-)

