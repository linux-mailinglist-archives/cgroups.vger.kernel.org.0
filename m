Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60414D1A6A
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 15:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347460AbiCHO0O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Mar 2022 09:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347353AbiCHO0N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Mar 2022 09:26:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB9744B85A
        for <cgroups@vger.kernel.org>; Tue,  8 Mar 2022 06:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646749516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kumltRP5xoYTs9zCrvASai08H9k31B5+7rHSh9VugPY=;
        b=ADmLXKci3Xi1UhGW8jGaOgku9aVYraNr4Tryx4xfQM+5SvL6p80vM/0mAQM5eQN8ud6YCF
        gF2cYnTGvDIczn60qgg7NnmWSVAMLZGmHQjtJkTd55XY2K9snh8xaUeoRTpUKrtayN4bqI
        eUFhPe8UcXz3VXZy+pKmbrkAAWAgTKU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-j-uLe7cLNpqp1WRSJh67fA-1; Tue, 08 Mar 2022 09:25:14 -0500
X-MC-Unique: j-uLe7cLNpqp1WRSJh67fA-1
Received: by mail-wm1-f70.google.com with SMTP id 7-20020a1c1907000000b003471d9bbe8dso959275wmz.0
        for <cgroups@vger.kernel.org>; Tue, 08 Mar 2022 06:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=kumltRP5xoYTs9zCrvASai08H9k31B5+7rHSh9VugPY=;
        b=GcKPNPSGs56SFQpouPkOVZOabbXboqKT5dyFtcs402+9SadWm1Mm1Jkb4CtZLypyQg
         7xqoDVDqsFn+aAc7xWV5+XX03w57JJFDuMzoBoQUsfkRxmRleT0Rk1ynI5cfTaC9XOtv
         fotvSkNu2IumtORhgVa/gFPumhFeYDTLO4gOtwKqGj1r4tRFZYbUEgnIlZTwPYObEJhY
         IjQPmk0a+3YAOcPsJ+Kbi1Bg1db8D4VTVKWGVspq1jz6vkza++ZoQ8uxI+IYf0YvjZQI
         pcb0nbfpOUAkcTb2hsZAvw+uNdPVltzsViiouJSkvW2S+Si/Lhx0J2L5FXG9xRtRtkuq
         GAbA==
X-Gm-Message-State: AOAM531XryYsPMmV/9Gb1uS2gUsFOkWJGfPYGeWpeXoN1/y8DkHUW0f+
        EzTUdOTa9TLtOoLIQtsnIUSFdSVzaJ7pmlJAv0rdv+2w50dD3ujxOMzQRNtr4PA2fveYc+9hRne
        whV5u9xQWuI9q6Gls1w==
X-Received: by 2002:a05:6000:154b:b0:1f0:6019:ea3a with SMTP id 11-20020a056000154b00b001f06019ea3amr12330575wry.395.1646749512992;
        Tue, 08 Mar 2022 06:25:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxznZCLNljth4M8V08Um5+lfKLr3E/0Oh4tOhNEBRjr9ngJ4D3YE+L+JEPV/yWQExUVOsyeVQ==
X-Received: by 2002:a05:6000:154b:b0:1f0:6019:ea3a with SMTP id 11-20020a056000154b00b001f06019ea3amr12330552wry.395.1646749512782;
        Tue, 08 Mar 2022 06:25:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id v14-20020adfd18e000000b0020373e5319asm244959wrc.103.2022.03.08.06.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:25:12 -0800 (PST)
Message-ID: <d170ca91-4913-900c-1d2b-b8fc63076124@redhat.com>
Date:   Tue, 8 Mar 2022 15:25:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] KVM: use vcalloc/__vcalloc for very large allocations
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
 <20220308105918.615575-4-pbonzini@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220308105918.615575-4-pbonzini@redhat.com>
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
> Allocations whose size is related to the memslot size can be arbitrarily
> large.  Do not use kvzalloc/kvcalloc, as those are limited to "not crazy"
> sizes that fit in 32 bits.  Now that it is available, they can use either
> vcalloc or __vcalloc, the latter if accounting is required.
> 
> Cc: stable@vger.kernel.org
> Cc: kvm@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")

?

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

