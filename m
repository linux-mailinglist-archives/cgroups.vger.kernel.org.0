Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CC34D1A76
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 15:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiCHO2k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Mar 2022 09:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiCHO2j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Mar 2022 09:28:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 209C92A717
        for <cgroups@vger.kernel.org>; Tue,  8 Mar 2022 06:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646749662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/dhr5xlK4pqXG8WmMyzbGqgbqfGKBQGaX2lWQVYPyM=;
        b=ewTR1t91FHrT2tC5rpvG96tV0Eqca+vsj1xcBYY42s5d5nsDYC9fIMUYP5Rz/PC8Eq/ezB
        ImnOP1tUo2jFAmFphfQ+T1DussaaX5Y9FQ7VLu8cslqbi2VrSlkU5XY7R0uGbKVxjhUX0F
        fCUVCDr9ekz3OXO9NRL5oSfpfz4L4RU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-g8W9AMeOO46ysPiaMGoC1Q-1; Tue, 08 Mar 2022 09:27:40 -0500
X-MC-Unique: g8W9AMeOO46ysPiaMGoC1Q-1
Received: by mail-wm1-f70.google.com with SMTP id j42-20020a05600c1c2a00b00381febe402eso1256301wms.0
        for <cgroups@vger.kernel.org>; Tue, 08 Mar 2022 06:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=N/dhr5xlK4pqXG8WmMyzbGqgbqfGKBQGaX2lWQVYPyM=;
        b=T/snb3oZ/t9xPl4BgR+A/yJ2f+C0PjPSD3cDNp6V2akJ9zOfaOjsQv+Bq7YFE3m4nG
         a4KTRp84/f4SwXt9ME8ulY/ZzWl8lKFI8YYWGA4FoDSX8A4RuuCk0fbVBjvfWzr4/5R6
         69kTxUpyMlO7buhWpewIrbh89MiPslW4+0YIvv04KOZiy//LX6dJYNzfQI1Xw/6CmX8k
         ODEoZK9yZ42BNhhJrgeWLSTZEP5qGlD2quf7g5cQ8Q0pfKuaMAKnqn0C/3x9W+6g7cBu
         SeXIF1H0iVM4u1gJNGH90EJo8BKrbiaeWAdIFv/7xLPuH4WEMe6K8JaXHWKVpjpGkJ8g
         ZvPQ==
X-Gm-Message-State: AOAM53133OV6QY3Q3uWwmy1OZCZE0kQpzKq5Sxv5BkhxRM1FBjRlA0Bq
        OaLwG4kYvThdUczCCig0QmqkNi1UfV4jMa7qKhi1jIW0tp4cNqDOyLoz4yETkLFP+1LXeb0g5HT
        G3fQ6ku3a8DOBihtmug==
X-Received: by 2002:a5d:69c7:0:b0:1f0:61f3:642b with SMTP id s7-20020a5d69c7000000b001f061f3642bmr12700039wrw.632.1646749659488;
        Tue, 08 Mar 2022 06:27:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWdPmIxNsxLTh1P63sfKpat50885bbogAIw47eOBkt/JfFNDmVkfT5yPb1SfXxU4norf0w6Q==
X-Received: by 2002:a5d:69c7:0:b0:1f0:61f3:642b with SMTP id s7-20020a5d69c7000000b001f061f3642bmr12700020wrw.632.1646749659254;
        Tue, 08 Mar 2022 06:27:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600003cc00b001f34d8c5baesm4193308wrg.78.2022.03.08.06.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:27:38 -0800 (PST)
Message-ID: <8d036ae0-9280-0d53-02dd-179ba46f908f@redhat.com>
Date:   Tue, 8 Mar 2022 15:27:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] mm: use vmalloc_array and vcalloc for array
 allocations
Content-Language: en-US
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
References: <20220308105918.615575-1-pbonzini@redhat.com>
 <20220308105918.615575-3-pbonzini@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220308105918.615575-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 08.03.22 11:59, Paolo Bonzini wrote:
> Instead of using array_size or just a multiply, use a function that
> takes care of both the multiplication and the overflow checks.
> 
> Cc: linux-mm@kvack.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

