Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC66523B39
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 19:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbiEKRNy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 13:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243500AbiEKRNy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 13:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81A941756B6
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652289232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EE9Fagjhe/kqd3S9iC2YvYzVpVJK7eXKAdqNAWFHIas=;
        b=V+nCXNPDJ8h3Ey9KSjR+gF+xpXUiWUEsQ0UNAC+Cd4kYrfHmJBForclQk9zEeaTWrwhSTn
        qB4uH+s7rUsq8Ud4iXtJLQpPSHeODg1KsrfObk4iGNaF0hgvoVnoGPxX+z5rQ1wMemZWAz
        mWoQFVYvHiu8JgMNamhzuEbJ/HIF3OY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-bJmaaXLFNoGR2XVNjN4AuQ-1; Wed, 11 May 2022 13:13:51 -0400
X-MC-Unique: bJmaaXLFNoGR2XVNjN4AuQ-1
Received: by mail-wr1-f72.google.com with SMTP id ba21-20020a0560001c1500b0020ca6a45dfcso1086205wrb.9
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 10:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=EE9Fagjhe/kqd3S9iC2YvYzVpVJK7eXKAdqNAWFHIas=;
        b=uYZJhVZHR3ZdCmLwgC7IbCkVJnBkgjDv1Yvk2xP4PGDfYywsUeAF7gqIVOj7FucT4y
         hvqo52x41N8gNhJBoXl7HAun4A2OBk1NbHdJde46x5UkI7TnSNyQwLDdrkPUKaSG+254
         2XHVIX2YopaCJm4Qn8rOwjQIr/bvfjoJmWrVFklzQZw8O5T6b0qqInJBsG2zvw9B0BlZ
         oyDwkJ8HTNKlci7e6WXRhPVO8g3KeZp00eB5TmQWByseay0+9ZHHeYFgEcG0xDJQ/jpm
         i0W6uzHUBm4VMS2k3slfPNwW/iyZqc164PyUmJWSGPzd7CI9xyC2W+8gK6YshYPYFLwJ
         1q4A==
X-Gm-Message-State: AOAM530O+e3lS+gF7IMdd2gPa87Msx8h8AMyhfkym8Mbt5FMJqK5c6Ni
        OnSXZszZJ7Bx1hSF07Jn564/Dfd4NoTlRPNvlRlerDHUUGVBqVbL39RCn27ID5/4gPS4324lRPt
        vnSaJ15mgOGJA4kEaAw==
X-Received: by 2002:a05:6000:1f1a:b0:20c:d84b:5863 with SMTP id bv26-20020a0560001f1a00b0020cd84b5863mr7146321wrb.277.1652289229998;
        Wed, 11 May 2022 10:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtVDDFsoc9w/8xVTQ/+hbmOEJtpXNmZ6DvqciF88VCZQENnuUJU2+YJE5rSrhhzo12JrSDgQ==
X-Received: by 2002:a05:6000:1f1a:b0:20c:d84b:5863 with SMTP id bv26-20020a0560001f1a00b0020cd84b5863mr7146292wrb.277.1652289229792;
        Wed, 11 May 2022 10:13:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:700:2393:b0f4:ef08:bd51? (p200300cbc70107002393b0f4ef08bd51.dip0.t-ipconnect.de. [2003:cb:c701:700:2393:b0f4:ef08:bd51])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c2e0c00b003945781b725sm282850wmf.37.2022.05.11.10.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:13:49 -0700 (PDT)
Message-ID: <f153dd2c-574a-a303-4f54-9e1396b131f9@redhat.com>
Date:   Wed, 11 May 2022 19:13:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 5/6] mm: zswap: add basic meminfo and vmstat coverage
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-6-hannes@cmpxchg.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220510152847.230957-6-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10.05.22 17:28, Johannes Weiner wrote:
> Currently it requires poking at debugfs to figure out the size and
> population of the zswap cache on a host. There are no counters for
> reads and writes against the cache. As a result, it's difficult to
> understand zswap behavior on production systems.
> 
> Print zswap memory consumption and how many pages are zswapped out in
> /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

