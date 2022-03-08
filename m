Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A10C4D1A70
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 15:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243652AbiCHO1i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Mar 2022 09:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbiCHO1h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Mar 2022 09:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F184A4BBA7
        for <cgroups@vger.kernel.org>; Tue,  8 Mar 2022 06:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646749600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cfnVlv/RlDuTe6slefgIRueT6ZidGHZwyrNWbarjPs=;
        b=b3IQ8a7iD+nhT+YNAZooYl6eCXcuutjdBfpydxw8ECy+6VRvUGqAUuAX0BSnpoK1QYID5I
        bN/OTuZzNu3t5opgSq9D7tW96Mme452A5nBGGFktkpa4MtUQBuTnDIxmZvB71+lOW2uR2m
        v9GrxpOaVgJIftsPdqSEaJHrhzREQoU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-FpJRL4ZJOn2-Uad6pOy1Dg-1; Tue, 08 Mar 2022 09:26:39 -0500
X-MC-Unique: FpJRL4ZJOn2-Uad6pOy1Dg-1
Received: by mail-wm1-f71.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so1168421wmj.5
        for <cgroups@vger.kernel.org>; Tue, 08 Mar 2022 06:26:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=3cfnVlv/RlDuTe6slefgIRueT6ZidGHZwyrNWbarjPs=;
        b=q5ZxFrrfF0q0hviSdDsI3uceCmaWCmJ5D09lYJ5JfLRcof++TuRXPI8LgITQiaZG6S
         aa2vZv0JaljXkOk9Vi0sKkA0gI4zd1RTi6HGBKyPrukUaT9wM4uczMyfNTJFfFkS+4GC
         7+jbNSbDtnPU/fTfSf9fv1XZPkLFgBW0KP8AikfvQ+QlgjQG94O8JchtraHx5Acs41mn
         geMEqTxAzft00ne7WsrUJlOhaEcTNsEpuw7PMSwFcCmwJlJAEsYgtwRx6vl2foezuw8X
         A5jmHsqx5oK73uTTYWJi2nAfVTjDkoPpnV9v+xmY5UX9ia+AnlefyK20/RYSl8ZI6ORe
         2g4Q==
X-Gm-Message-State: AOAM530oDeg8DL8lZ1ef1vRXp7JArRqYeq6pgoAOdpTpNR0jsEe6/KN0
        erickhJ/NabYxvep63ROSDbkiyuvre9a0bUalDn4OnsgSw4zp0y60zsNQcxJmB2EGUd5R+eSM+n
        qCzN+WDoGMZkMrP4dLw==
X-Received: by 2002:a7b:c19a:0:b0:381:8495:9dd with SMTP id y26-20020a7bc19a000000b00381849509ddmr3855589wmi.33.1646749597818;
        Tue, 08 Mar 2022 06:26:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkGMqy96yeJ8eyYni5tPRSuAQRhYRfLLgmbxcVTC7rowBhEVZ4HEOW0M2LoIj2T2UswTF6JA==
X-Received: by 2002:a7b:c19a:0:b0:381:8495:9dd with SMTP id y26-20020a7bc19a000000b00381849509ddmr3855562wmi.33.1646749597564;
        Tue, 08 Mar 2022 06:26:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id u4-20020adfed44000000b0020373d356f8sm295983wro.84.2022.03.08.06.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:26:37 -0800 (PST)
Message-ID: <1338e4bf-015d-3323-1b8e-3a9e80d254a1@redhat.com>
Date:   Tue, 8 Mar 2022 15:26:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] mm: vmalloc: introduce array allocation functions
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
        cgroups@vger.kernel.org, stable@vger.kernel.org
References: <20220308105918.615575-1-pbonzini@redhat.com>
 <20220308105918.615575-2-pbonzini@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220308105918.615575-2-pbonzini@redhat.com>
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
> Linux has dozens of occurrences of vmalloc(array_size()) and
> vzalloc(array_size()).  Allow to simplify the code by providing
> vmalloc_array and vcalloc, as well as the underscored variants that let
> the caller specify the GFP flags.
> 
> Cc: stable@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

