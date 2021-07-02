Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6413B9D80
	for <lists+cgroups@lfdr.de>; Fri,  2 Jul 2021 10:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhGBI3H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jul 2021 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhGBI3D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jul 2021 04:29:03 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F091C061762;
        Fri,  2 Jul 2021 01:26:31 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id dj3so4288336qvb.11;
        Fri, 02 Jul 2021 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:to:cc:subject:mime-version:date
         :content-transfer-encoding;
        bh=dX6i2Y1Ly1681d2mbj0j/9kxKdKTvA3NyPTEzjPTIAo=;
        b=O0MCkaYt1focsaJcVAnZ1S3briveTgqC3Ppgjih1yaYijWRG7f96cLefa3xqTEXomV
         L4dvYp//TA70BCp2Y3yTdZEUpbA0RcpZayLdNh/QtlwhM2qs/gL+IAN8/dqfZH1VTgnk
         7CCVSwasXmTbRUGlu+Kap89MRd5Gy4dF7cX0NSXi14ofkkD7KtRIMohmR1zUkUD4iSmJ
         HT6OVSzRb61vhdKRpbQ4ftZEdX7zg7/FJl36V7/CQME95EO0rmAaaAYZsh6Qm+o2i0MG
         wZY8xzG6jSN8YhuaG1XCLriRGNqQx9yr/ciYt31BR9wJaIsJHCWl41Hn/7tP/HPRD6Aa
         mI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:mime-version:date
         :content-transfer-encoding;
        bh=dX6i2Y1Ly1681d2mbj0j/9kxKdKTvA3NyPTEzjPTIAo=;
        b=D19QPSC0w0UnVSfGlFQ1EVteeCjlfzdM4qnok2FeOXnQOBbrtI5gEr9TNlg3woqqNP
         Lnfp35a9kNLpU4PJfcRLVBrAIIRyQEmBqtWfqu+jmVDEAetYRgZbXOj5JdnhxDv/uiYP
         IvWREgoCAUEq3mlfooQI9vKCoWiYC/B5Z0HvUiaL07uTaJfBpc2Vyv1Rbzj64/AX0khP
         +mgTeDC8dCdUMSKnXwgKNufjIXORYDpALIaXPXlC/xyV/u87ZPmNQ6AQ3GyYmh8tmgsq
         3NJgTD1r+qhXLa+iDRKR6bdBnrgfpyj9FaRFRORWMjvEAqE9aVzRBpbgNtPftOGIwYNJ
         jAtg==
X-Gm-Message-State: AOAM530xGiyJH2uvf7xyFOlKLWBSw2AzaC6K4NqiygPby/M5JT9HOCve
        QHnIPnVYQ/xhkMjOyrn1Y0Bw+rVt0/+bOw==
X-Google-Smtp-Source: ABdhPJyh1faEm+PaNeHQWlnYm8PYe1qU9GMOX7JUK3+hWCk+yPFaT7RsCTS7Vx/6axzlT9K6e3ZgJA==
X-Received: by 2002:a0c:9ac7:: with SMTP id k7mr4078405qvf.49.1625214390729;
        Fri, 02 Jul 2021 01:26:30 -0700 (PDT)
Received: from 53a3b1cb497b ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id 19sm979536qtt.87.2021.07.02.01.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 01:26:30 -0700 (PDT)
Message-ID: <60decdb6.1c69fb81.6130e.7642@mx.google.com>
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tj@kernel.org
Subject: [Question] Do we need remote charging for cpu and cpuacct subsys?
MIME-Version: 1.0
Date:   Fri, 02 Jul 2021 08:26:27 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

SGksCgptZW1jZyBjdXJyZW50bHkgaGFzIGEgcmVtb3RlIGNoYXJnaW5nIG1lY2hhbmlzbSB0aGF0
IGNhbiBjaGFyZ2UgdXNhZ2UgdG8gb3RoZXIKbWVtY2cgaW5zdGVhZCBvZiB0aGUgb25lIHRoZSB0
YXNrIGJlbG9uZ3MgdG8uCgpJbiBvdXIgZW52aXJvbm1lbnQsIHdlIG5lZWQgdG8gYWNjb3VudCB0
aGUgY3B1IHVzYWdlIGNvbnN1bWVkIGJ5IHNvbWUga3dvcmtlcnMKdG8gYSBzcGVjaWZpYyBjZ3Jv
dXAuIFRodXMsIHdlIHdhbnQgdG8gaW50cm9kdWNlIGEgcmVtb3RlLWNoYXJnaW5nIG1lY2hhbmlz
bSB0bwpjcHUgYW5kIGNwdWFjY3Qgc3Vic3lzIGluIG91ciBrZXJuZWwuCgpJIHdhbnQgdG8ga25v
dyBpZiB0aGUgY29tbXVuaXR5IGhhcyBhIHBsYW4gdG8gZG8gdGhpcz8KV2hhdCB3aWxsIHRoZSBj
b21tdW5pdHkgYXBwcm9hY2ggbG9vayBsaWtlPwoKSSB0aGluayB3ZSBuZWVkIHRvIG1vdmUgdGhl
IGFjdGl2ZV9tZW1jZyB0byBhIHNlcGFyYXRlZCBhY3RpdmVfY2dyb3VwIHN0cnVjdCwKYW5kIHRo
ZSBsYXR0ZXIgd2lsbCBjb250YWluIGFjdGl2ZV9tZW1jZywgYWN0aXZlX3RnLCBhbmQgYWN0aXZl
X2NwdWFjY3QuCgoKUmVnYXJkcywKSGFvIExlZQo=

