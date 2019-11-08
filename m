Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6F5F59D5
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2019 22:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbfKHV04 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Nov 2019 16:26:56 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:47031 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730989AbfKHV04 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Nov 2019 16:26:56 -0500
Received: by mail-qk1-f182.google.com with SMTP id h15so6560341qka.13
        for <cgroups@vger.kernel.org>; Fri, 08 Nov 2019 13:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=E/re/TtVqjhhFyMNUDrEMQoMA+rNSBWgaDnjt6xblfc=;
        b=BGsscPnI0I/AhxQtkp1ur0VrFYXf5H8Fg7QmP8nllWAk3LB+1xRvuro/YNq+Wi4p5F
         3ZAD5u8+aHKV6BCRpJFppf3VuxZKf/sv7n021xyePsMo0qyk4ioIipKyJxsfny2R6RX3
         muOR0J1B2kxQSzV9581+eZYOESV3d8dZz1I/0lFZM3rKt3ovoGT+VSWRIahQ6OsN3IV1
         s8FtMLqcLzCVTjdBygGBm4m5G43Y6e3kQ7cTLWjekKCGP5ylAKVgqVGK8DUT21Ht4cN8
         7GXkMXTsKy8U08dIiAi7+G9AKRSNl22O/wb8ep0nz17TwjAIvaYLFkN2KBK6QMSY1A7d
         ming==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=E/re/TtVqjhhFyMNUDrEMQoMA+rNSBWgaDnjt6xblfc=;
        b=Jxm0lhv38QnlAK1uhoO27xWAZIi7L8AeRr3h8TwzZgeWeTshec3WyR2ojPWeoX2svT
         3x5PM3N+Bi/jaQwemVsX5tinM+NV9CLkXQnR7GVna/E7OaXUfwwLPxFmH+hX+gvhYW/U
         UxPTWCPE/UvjGbuhPc3T5isgiiLhiFRmgzp4MYBlr5KKaLyEn5xDkMpQoxUf0b7T/S8/
         swRr8PXjjaVvHcZ6AJrF5Aa5pmyvaTTChrLDhA4plGHiVbCO3aK83WK+Z9xIxvGsf3mM
         9MtuCelZrRtoCTew56DgB2fLjcI8q3ejEKTaDmdBK/bqglI3vaI/oe31OHi8ssOoHHh2
         wjow==
X-Gm-Message-State: APjAAAW1S0XDoRJnS4PaCGkoGpNdJ4BQ8iF5McKks1p1liG84EGzhw42
        TF54+BkYUAovqdUbRrxeLfi7rA==
X-Google-Smtp-Source: APXvYqyLA9raRCjGEtQ5L5aO6bE7f5z5e7jdeJYvdN/uTfRWHR1m08qA/W6lvIBR0YH8Zrl54083xw==
X-Received: by 2002:a37:9d86:: with SMTP id g128mr11128288qke.191.1573248415230;
        Fri, 08 Nov 2019 13:26:55 -0800 (PST)
Received: from ?IPv6:2600:1000:b04c:9cbe:6d67:a89d:e323:d2c? ([2600:1000:b04c:9cbe:6d67:a89d:e323:d2c])
        by smtp.gmail.com with ESMTPSA id o2sm3375987qte.79.2019.11.08.13.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 13:26:54 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
Date:   Fri, 8 Nov 2019 16:26:52 -0500
Message-Id: <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
References: <20191108204407.1435-1-cai@lca.pw>
Cc:     mhocko@suse.com, hannes@cmpxchg.org, guro@fb.com,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108204407.1435-1-cai@lca.pw>
To:     akpm@linux-foundation.org
X-Mailer: iPhone Mail (17A878)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Nov 8, 2019, at 3:44 PM, Qian Cai <cai@lca.pw> wrote:
> 
> -    for (zid = 0; zid <= zone_idx; zid++) {
> +    for (zid = 0; zid < zone_idx; zid++) {
>        struct zone *zone =

Oops, I think here needs to be,

for (zid = 0; zid <= zone_idx && zid < MAX_NR_ZONES; zid++) {

to deal with this MAX_NR_ZONES special case.
