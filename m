Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE33314D267
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2020 22:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgA2VVy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jan 2020 16:21:54 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55495 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgA2VVy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Jan 2020 16:21:54 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so342851pjz.5
        for <cgroups@vger.kernel.org>; Wed, 29 Jan 2020 13:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fSu1mCirRVJUEaT+xu3QH4J7cMfTuyOkl0e/HLlkDbU=;
        b=P/D+X34DyFIVyb02XfVKy0ez7sqi3JEfNxP0fAGOgGmxc1cVKQ9rGo+vjzEILUFZYY
         Th6TqFfL/TeL6mjRI1wEB1tf6SKODMXuKHiHGuUkNzirxDxr1isbiii+zASEv0IgrlMt
         XOk+l8dhoulN6hdPOkhiOypf3L8b2P+1jI+lfCTBd+RxcX5LtJoQGNa45TGmQl0gCAMy
         6+MTywXj7bOpvfE6pqDPCEil8nOdV7/3VBcmgVrxE4eNto2UBQkxzApfPQ97iURPOylx
         wJjgAC3U/gPQTvu2jiC/Q3wVMMMRHWtsnUvhcNxk9ON65oZcbx7eDZiCGIDSuRA7UJJt
         fx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fSu1mCirRVJUEaT+xu3QH4J7cMfTuyOkl0e/HLlkDbU=;
        b=pGqSLk1+BY/Ck7QOnI3kg8I+MaJqWyQ5OROUOGfw9rYhuezOERXYwd7tffyCJ9VIkS
         S2eTaj/mPxPTTBD+XAJwhn0ddSQM7lgxcQW2woEgjQw92x/4mT8qjZKg/OFgSO+kLKwj
         ikVV86xfgu8n3TW0lLtQ7bkJ0xmjQeW67jIN9SOL5sbEFcNJ/ULnlgKF7wrtQmbs4akZ
         roBf+JXk/6vL4DQkkz6Gk5OndPGkkos8RBf5wxzT0rlcHJSRFag+g0IlehZ38CNOBWPf
         4rNV0cqDyH8dz/pI2w1QClC/rylK0csKq7k2iI07vGpvWPrB5chERBZExOAVW2+Q2R6v
         BY8Q==
X-Gm-Message-State: APjAAAVXFdOAcHgySz7C7+jg14Ylar6YnYpAZ6ErfW1xqWd05MEFx5HD
        R5ak33F3ZSsGCnMedFZSoVWoQg==
X-Google-Smtp-Source: APXvYqzGWo58ejovUm6nF7NJLFty3hOvszT3cTmNTbY14PSI28WNkitrX9z+LDyHBkwotFjy817GTg==
X-Received: by 2002:a17:90a:1f8c:: with SMTP id x12mr1900049pja.27.1580332913389;
        Wed, 29 Jan 2020 13:21:53 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u128sm3635727pfu.60.2020.01.29.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 13:21:52 -0800 (PST)
Date:   Wed, 29 Jan 2020 13:21:52 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mina Almasry <almasrymina@google.com>
cc:     mike.kravetz@oracle.com, shakeelb@google.com, shuah@kernel.org,
        gthelen@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v10 2/8] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
In-Reply-To: <20200115012651.228058-2-almasrymina@google.com>
Message-ID: <alpine.DEB.2.21.2001291312490.175731@chino.kir.corp.google.com>
References: <20200115012651.228058-1-almasrymina@google.com> <20200115012651.228058-2-almasrymina@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 14 Jan 2020, Mina Almasry wrote:

> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> index 063962f6dfc6a..eab8a70d5bcb5 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -20,29 +20,37 @@
>  struct hugetlb_cgroup;
>  /*
>   * Minimum page order trackable by hugetlb cgroup.
> - * At least 3 pages are necessary for all the tracking information.
> + * At least 4 pages are necessary for all the tracking information.
>   */
>  #define HUGETLB_CGROUP_MIN_ORDER	2

I always struggle with a way to document and protect these types of 
usages.  In this case, we are using the private filed of tail pages; in 
thp code, we enumerate these usages separately in struct page: see "Tail 
pages of compound page" comment in the union.  Using the private field is 
fine to store a pointer to the hugetlb_cgroup, but I'm wondering if we can 
document or protect against future patches not understanding this usage.  
Otherwise it's implicit beyond this comment.

Maybe an expanded comment here is the only thing that is needed because 
it's unique to struct hugetlb_cgroup that describes what struct page 
represents for the second, third, and (now) fourth tail page.

Or, we could go even more explicit and define an enum that defines the 
third tail page is for hugetlb_cgroup limits and fourth is for 
hugetlb_cgroup reservation limits.

enum {
...
	H_CG_LIMIT,
	H_CG_RESV,
	MAX_H_CG_PRIVATE,
};

and then do a

BUILD_BUG_ON(MAX_H_CG_PRIVATE > (1 << HUGETLB_CGROUP_MIN_ORDER));

somewhere?  And then use H_CG_RESV (or a better name) as the offset from 
the head page in the code?

> 
>  #ifdef CONFIG_CGROUP_HUGETLB
> 
> -static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
> +static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
> +							      bool reserved)

When implementing specs, I immediately see "bool reserved" or 
"int reserved:1" as reserved for future use :)  Maybe simple enough to 
just name these formals as resv?

Otherwise looks like a simple conversion of existing functionality and 
extension to the new limits.

Acked-by: David Rientjes <rientjes@google.com>
