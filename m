Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67DE310E2D9
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2019 19:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfLASPZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 1 Dec 2019 13:15:25 -0500
Received: from mtax.cdmx.gob.mx ([187.141.35.197]:14798 "EHLO mtax.cdmx.gob.mx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbfLASPZ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 1 Dec 2019 13:15:25 -0500
X-Greylist: delayed 6232 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Dec 2019 13:15:24 EST
X-NAI-Header: Modified by McAfee Email Gateway (4500)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cdmx.gob.mx; s=72359050-3965-11E6-920A-0192F7A2F08E;
        t=1575217543; h=DKIM-Filter:X-Virus-Scanned:
         Content-Type:MIME-Version:Content-Transfer-Encoding:
         Content-Description:Subject:To:From:Date:Message-Id:
         X-AnalysisOut:X-AnalysisOut:X-AnalysisOut:
         X-AnalysisOut:X-AnalysisOut:X-SAAS-TrackingID:
         X-NAI-Spam-Flag:X-NAI-Spam-Threshold:X-NAI-Spam-Score:
         X-NAI-Spam-Rules:X-NAI-Spam-Version; bh=M
        8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs4
        8=; b=J72jnZ6ndjfZJ/kI7njX60J9Xm/ribOo74atOguSe2Yl
        F+ZpNHwb5+3tliudUB7+nRj0wBMzM5pKUjOgR81h1wB74bUoDl
        Lr1ycQazheySg7zylEFwij7uVNq4UDfvWHFkcImPTtHIANOGvZ
        Rc4lpw2vrQUwvf7aSyWVLizwt2o=
Received: from cdmx.gob.mx (correo.cdmx.gob.mx [10.250.108.150]) by mtax.cdmx.gob.mx with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 1a22_4f73_84cd3648_3ae9_4bfb_9499_0a83b1bae76a;
        Sun, 01 Dec 2019 10:25:42 -0600
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id B762D1E29CA;
        Sun,  1 Dec 2019 10:17:56 -0600 (CST)
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id v3LlN5wxJ4_4; Sun,  1 Dec 2019 10:17:56 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id D2FDC1E275C;
        Sun,  1 Dec 2019 10:12:47 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx D2FDC1E275C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=72359050-3965-11E6-920A-0192F7A2F08E; t=1575216767;
        bh=M8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs48=;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:To:
         From:Date:Message-Id;
        b=QEhH2+9RJyvMyn9aNWKA9Qdcq/2+wQNmCK9784E4+wGYvL+mC6VoUxbx3n56NMYoX
         LwKzBPbQLDRHT5RlLcR1Q0lIYivbShQlISPMQkBzTYl/c2UiOuET+bLqjagPw+Osd+
         ODbG9nIUxHfFYaSXl/Uvbzk08H/kFxzKVi5J2wKQ=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SX4R4wFKvbh6; Sun,  1 Dec 2019 10:12:47 -0600 (CST)
Received: from [192.168.0.104] (unknown [188.125.168.160])
        by cdmx.gob.mx (Postfix) with ESMTPSA id 898181E26AA;
        Sun,  1 Dec 2019 10:03:43 -0600 (CST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Congratulations
To:     Recipients <aac-styfe@cdmx.gob.mx>
From:   "Bishop Johnr" <aac-styfe@cdmx.gob.mx>
Date:   Sun, 01 Dec 2019 17:03:31 +0100
Message-Id: <20191201160343.898181E26AA@cdmx.gob.mx>
X-AnalysisOut: [v=2.2 cv=cLaQihWN c=1 sm=1 tr=0 p=6K-Ig8iNAUou4E5wYCEA:9 p]
X-AnalysisOut: [=zRI05YRXt28A:10 a=T6zFoIZ12MK39YzkfxrL7A==:117 a=9152RP8M]
X-AnalysisOut: [6GQqDhC/mI/QXQ==:17 a=8nJEP1OIZ-IA:10 a=pxVhFHJ0LMsA:10 a=]
X-AnalysisOut: [pGLkceISAAAA:8 a=wPNLvfGTeEIA:10 a=M8O0W8wq6qAA:10 a=Ygvjr]
X-AnalysisOut: [iKHvHXA2FhpO6d-:22]
X-SAAS-TrackingID: 589e3ed5.0.90878324.00-2273.152481451.s12p02m012.mxlogic.net
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 3
X-NAI-Spam-Score: -5000
X-NAI-Spam-Rules: 1 Rules triggered
        WHITELISTED=-5000
X-NAI-Spam-Version: 2.3.0.9418 : core <6686> : inlines <7165> : streams
 <1840193> : uri <2949748>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Money was donated to you by Mr and Mrs Allen and Violet Large, just contact=
 them with this email for more information =


EMail: allenandvioletlargeaward@gmail.com
